extends Item

var target_position := Vector2(0,0)
var is_shooting = false

var frame_time = 1.0/60.0

@export var draw_step = 5.0
@export var move_speed = 200.0 #TODO: мб добавить небольшой заступ для точек

var undraw_time = 1.0/(move_speed/draw_step) * 0.3
var undraw_timer

var min_distance = 1.0

@export var on_hit_impulse_x = 100.0

@onready var damage_point = $"Tongue/Damage Area"
@onready var line = $Tongue/Line2D
var  last_drawed_point

var attack_timer
@export var cooldown_attack_time = 30 * frame_time
#TODO: Добавить реакцию лягушки не только на игрока
 #FIXME: отключать коллизию дамажащей зоны
func _ready():
#region Таймер для уменьшения языка
	undraw_timer = Timer.new()
	undraw_timer.autostart = false
	undraw_timer.one_shot = false
	undraw_timer.wait_time = undraw_time
	add_child(undraw_timer)
	undraw_timer.timeout.connect(_on_undraw_timeout)
#endregion
	attack_timer = Timer.new()
	attack_timer.autostart = false
	attack_timer.one_shot = true
	attack_timer.wait_time = cooldown_attack_time
	add_child(attack_timer)
	attack_timer.timeout.connect(_on_attack_cooldown_timeout)

func _on_attack_cooldown_timeout():
	$"Agr Area/CollisionShape2D".disabled = false

func _on_agr_area_body_entered(body):
	if !is_shooting and !is_catched:
		is_shooting = true
		target_position = body.global_position
		$"Agr Area/CollisionShape2D".call_deferred("set_disabled", true)

func _physics_process(delta):
	if is_shooting:
		if  damage_point.global_position.distance_to(target_position) <= min_distance: #FIXME: проверять дистанция в рамках погрешности
			hide_tongue()
		
		damage_point.global_position = damage_point.global_position.move_toward(target_position, move_speed * delta)
		
		if !last_drawed_point:
			last_drawed_point = line.get_point_position(line.get_point_count()-1)
		
		if damage_point.global_position.distance_to(last_drawed_point) >= draw_step:
			line.add_point(damage_point.position)
			last_drawed_point = damage_point.position
			

func hide_tongue():
	is_shooting = false
	undraw_timer.start()
	damage_point.position = line.get_point_position(0)

func _on_undraw_timeout():
	if line.get_point_count() > 1:
		line.remove_point(line.get_point_count()-1)
	else:
		last_drawed_point = line.get_point_position(0)
		undraw_timer.stop()
		#FIXME: добавить таймер сюда
		attack_timer.start()
		

func _on_damage_area_body_entered(body):
	if is_shooting:
		hide_tongue()
		#if body.has_method("take_damage"):
			#body.take_damage() 
		
		if body.has_method("take_impulse"):
			var direction = 1
			if body.global_position.x > self.global_position.x:
				direction = -1
			body.take_impulse(Vector2(on_hit_impulse_x * direction,-50)) 
	
	
	#TODO: если имеет метод получить импульс - задать импульс, если получить дамаг - получить дамаг
	# и спрятать язык и отсновить shooting и запустить кд, выключить зону агра на время таймера

