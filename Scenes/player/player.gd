extends CharacterBody2D


@export var max_hp = 3
@export var hp = 3
signal update_health (hp: int)
signal player_death

var frame_time = 1.0/60.0
var jump_buffer = false #становится true после прожатия прыжка и через время становится false или после касания земли
var jump_aviable = true #доступность прыжка

var jump_buffer_time = 10 * frame_time
var jump_buffer_timer
var jump_timer
var is_jumping = false

var up_buffer = false
var up_buffer_time = 5 * frame_time
var up_buffer_timer


var is_falling = true

var is_hovered = false #зависание после прыжка
var hover_time = 5 * frame_time
var hover_timer

var koyote_time = 3 * frame_time #время койота
var koyote_timer
var is_koyote = false
var is_prev_frame_earth = false

var move_state = "default_state"
var location_type = "on_ground"

var is_pickuped = false
@onready var pickup_area = $PickupArea
var pickup_body: PhysicsBody2D

var world_node: Node

var take_drop_pressed_time: int

var last_direction_horizontal := 1.0 #последнее активное направление движения

var is_on_ladder = false 

var damage_take_timer
var damage_take_time = 30 * frame_time
var is_taking_damage = false


var start_falling_time = 0
var prev_is_falling = false

#в массивках указаные скорости [максимальная, ускорение и замедление]
#TODO: сделать замену чисел на слова для понятной работы с массивами
#TODO: заменить hover на парить
#TODO: использовать при задержка переменную из этого словаря
#TODO: реализовать как ресурс

@export var game_constant: GameConstant

func _ready():
	#region создание таймера буффера прыжка
	jump_buffer_timer = Timer.new()
	jump_buffer_timer.autostart = false
	jump_buffer_timer.one_shot = true
	add_child(jump_buffer_timer)
	jump_buffer_timer.timeout.connect(_on_jump_buffer_timeout)
	#endregion
	#region создание таймера прыжка
	jump_timer = Timer.new()
	jump_timer.autostart = false
	jump_timer.one_shot = true
	jump_timer.wait_time = game_constant.speed_dist["default_state"]["on_ground"]["jump_time"][0]
	add_child(jump_timer)
	jump_timer.timeout.connect(_on_jump_timeout)
	#endregion
	#region таймер зависания в прыжке
	hover_timer = Timer.new()
	hover_timer.autostart = false
	hover_timer.one_shot = true
	hover_timer.wait_time = hover_time
	add_child(hover_timer)
	hover_timer.timeout.connect(_on_hover_timeout)
	#endregion
	#region таймер койота
	koyote_timer = Timer.new()
	koyote_timer.autostart = false
	koyote_timer.one_shot = true
	koyote_timer.wait_time = koyote_time
	add_child(koyote_timer)
	koyote_timer.timeout.connect(_on_koyote_timeout)
	#endregion
	#region таймер буфера нажатия вверх
	up_buffer_timer = Timer.new()
	up_buffer_timer.autostart = false
	up_buffer_timer.one_shot = true
	up_buffer_timer.wait_time = up_buffer_time
	add_child(up_buffer_timer)
	up_buffer_timer.timeout.connect(_on_up_buffer_timeout)
	#endregion
	#region таймер неуязвимости после дамага
	damage_take_timer = Timer.new()
	damage_take_timer.autostart = false
	damage_take_timer.one_shot = true
	damage_take_timer.wait_time = up_buffer_time
	add_child(damage_take_timer)
	damage_take_timer.timeout.connect(_on_damage_take_timeout)
	#endregion
	update_health.emit(hp)

#region Функции таймаутов
func _on_damage_take_timeout():
	$AnimatedSprite2D.play("idle")
	is_taking_damage = false

func _on_up_buffer_timeout():
	up_buffer = false

func _on_koyote_timeout():
	is_koyote = false

func _on_hover_timeout():
	is_hovered = false

func _on_jump_timeout():
	is_jumping = false 
	is_hovered = true
	hover_timer.start()

func _on_jump_buffer_timeout():
	jump_buffer = false
#endregion


func _physics_process(delta):
	if is_on_floor():
		location_type = "on_ground"
		jump_aviable = true
		is_falling = false
		is_prev_frame_earth = true
	elif !is_on_ladder:
		if is_prev_frame_earth:
			is_prev_frame_earth = false
			koyote_timer.start()
			is_koyote = true
		elif !is_koyote:
			location_type = "on_air"
			is_falling = true 
	elif is_on_ladder and is_jumping:
		location_type = "on_air"
		is_falling = true
	
	if Input.is_action_just_pressed("move_up"):
		up_buffer = true
		up_buffer_timer.start()
	
	if up_buffer and is_on_ladder and !is_jumping:
		up_buffer = false
		location_type = "on_ladder"
		jump_aviable = true 
		is_falling = false
		velocity.x = 0
		velocity.y = 0 #FIXME: возможно надо поменять
	
	
	#region Вертикальное движение
	var direction_vertical = Input.get_axis("move_up", "move_down")
	var vertical = game_constant.speed_dist[move_state][location_type]["vertical"]
	if direction_vertical and vertical[0]:
		velocity.y = move_toward(velocity.y, direction_vertical * vertical[0], vertical[1] * delta)
	else:
		velocity.y = move_toward(velocity.y, 0, vertical[2] * delta)
	#endregion
	
#region Горизонтальное движение
	var direction_horizontal = Input.get_axis("move_left", "move_right")
	#FIXME: добавить изменение горизонтальное
	var horizontal = game_constant.speed_dist[move_state][location_type]["horizontal"]
	if direction_horizontal: 
		last_direction_horizontal = direction_horizontal
	if direction_horizontal and horizontal[0]:
		velocity.x = move_toward(velocity.x, direction_horizontal * horizontal[0], horizontal[1] * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, horizontal[2] * delta)
#endregion
	
#region Прыжок
	if Input.is_action_just_pressed("move_jump"):
		jump_buffer = true
		jump_buffer_timer.start(jump_buffer_time)
		if location_type == "on_ladder":
			location_type = "on_ground"
	if jump_buffer and jump_aviable and game_constant.speed_dist[move_state][location_type]["jump_time"][0] > 0:
		jump_timer.start(game_constant.speed_dist[move_state][location_type]["jump_time"][0])
		#FIXME: завершать таймер буффера после фактического прыжка
		jump_aviable = false
		jump_buffer = false 
		is_jumping = true
	
	var jumping = game_constant.speed_dist[move_state][location_type]["jumping"]
#endregion
	
	
	if is_jumping:
		velocity.y = move_toward(velocity.y, -1 * jumping[0], jumping[1] * delta)
	elif is_hovered:
		velocity.y = move_toward(velocity.y, 0, jumping[2] * delta)
	elif is_falling:
		var falling = game_constant.speed_dist[move_state][location_type]["falling"]
		if falling[0]:
			velocity.y = move_toward(velocity.y, falling[0], falling[1] * delta)

	if Input.is_action_just_pressed("action_take_drop"):
		take_drop_pressed_time = Time.get_ticks_msec()
	
	if Input.is_action_just_released("action_take_drop"):
		if !is_pickuped:
			pickup()
		else:
			#print(Time.get_ticks_msec()-take_drop_pressed_time)
			#TODO: замедление на время зажатия
			drop(Time.get_ticks_msec()-take_drop_pressed_time)
	elif Input.is_action_just_pressed("action_use"):
		#FIXME: добавить зону интеракции с наземными предметами
		if is_pickuped and pickup_body.has_method("get_active"):
			make_active(pickup_body.get_active())
	
	if !prev_is_falling and is_falling:
		start_falling_time = Time.get_ticks_msec()
	
	prev_is_falling = is_falling
	move_and_slide()

func pickup():
	if !is_pickuped and pickup_area.has_overlapping_bodies():
		var body_list = pickup_area.get_overlapping_bodies()
		var nearest_body = body_list[0] #находим ближайшее тело в зоне
		for body in body_list:
			if (body.global_position.distance_to(pickup_area.global_position)
					 < nearest_body.global_position.distance_to(pickup_area.global_position)):
				nearest_body = body
		
		pickup_body = nearest_body
		pickup_body.set_catched(true)
		pickup_body.reparent(self)
		pickup_body.global_position = $PickupCoord.global_position
		is_pickuped = true
		
		pickup_body.item_destroyed.connect(_on_item_destroy)
		update_collision_item()
		update_move_state()


func update_move_state():
	if is_pickuped and pickup_body and "item_state" in pickup_body:
		move_state = pickup_body.item_state
	else:
		move_state = "default_state"


func update_collision_item():
	if is_pickuped:
		$ItemCollisionShape2D.shape = pickup_body.get_node("CollisionShape2D").shape
		$ItemCollisionShape2D.global_position = pickup_body.global_position
		$ItemCollisionShape2D.disabled = false #FIXME: добавить проверки
	else:
		$ItemCollisionShape2D.disabled = true


func _on_item_destroy():
	pickup_body.item_destroyed.disconnect(_on_item_destroy)
	is_pickuped = false
	update_collision_item()
	update_move_state()

var drop_forces = [50,200,200,200]
var drop_timings = [500,1000,2000]

func drop(time: int):
	if is_pickuped:
		if !world_node:
			world_node = get_tree().current_scene
			if !world_node: return
		#print_debug(world_node.name)
		pickup_body.item_destroyed.disconnect(_on_item_destroy)
		pickup_body.reparent(world_node)
		
		var force = 0
		if time <= drop_timings[0]:
			force = drop_forces[0]
		elif time <= drop_timings[1]:
			force = drop_forces[1]
		elif time <= drop_timings[2]:
			force = drop_forces[2]
		else:
			force = drop_forces[3]
		
		pickup_body.set_catched(false)
		pickup_body.take_impulse(Vector2(last_direction_horizontal * force,-100))
		#print_debug(last_direction_horizontal * force)
		is_pickuped = false
		update_collision_item()
		update_move_state()

func _on_ladder_area_area_entered(_area):
	is_on_ladder = true

func _on_ladder_area_area_exited(_area):
	if !$"Ladder area".has_overlapping_areas():
		is_on_ladder = false

func get_falling_time_msec():
	if !is_falling:
		return 0
	return Time.get_ticks_msec() - start_falling_time

func take_damage():
	if !is_taking_damage:
		#TODO: анимация дамага
		is_taking_damage = true
		$AnimatedSprite2D.play("damaged")
		damage_take_timer.start()
		hp -= 1
		if hp <= 0:
			death()
		update_health.emit(hp)

func take_heal(heal_value = 1):
	#$AnimatedSprite2D.play("damaged") TODO: добавить анимацию хилла
	hp += heal_value
	if hp > max_hp:
		hp = max_hp
	update_health.emit(hp)

func take_impulse(impulse_vector):
	velocity.x = impulse_vector[0] * 3.5
	velocity.y = impulse_vector[1]
	#FIXME: Добавить время чтобы отобрать управление от пользователя

func death():
	#player_death.emit()
	#TODO: добавить анимацию смерти и отобрать управление от пользователя н
	get_tree().call_deferred("reload_current_scene")

var active_names := {
	"heal": take_heal,
}

func make_active(active_name):
	if active_name in active_names:
		active_names[active_name].call()
