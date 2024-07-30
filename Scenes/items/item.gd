class_name Item extends RigidBody2D

signal item_destroyed
signal item_catched (body)

@export var item_name := "item_box"
@export var is_foreground := true
@export var is_destroyable = false
@export var hp = 1
@export var is_taking_damage = true
@export var active := "none"
@export var is_consumable = false

@export_enum("default_state", 
"easy_state", "middle_state", "hard_state", "hover_state", 
"water_state", "underwater_state") var item_state: String = "easy_state"

var is_catched = false
var is_destroyed = false #НЕ знаю почему но даже после free() функция может вызываться

#FIXME: есть ли способ полностью отказаться от deferred
#TODO: добавить ограничение броска для тяжелых предметов
func get_active():
	if !is_destroyed:
		if is_consumable:
			destroy(true)
		return active


func _ready():
	self.set_collision_layer_value(3, !is_foreground)
	self.set_collision_layer_value(4, is_foreground)
	self.set_collision_layer_value(5, false)
	
	self.set_collision_mask_value(1, is_foreground)
	if is_foreground:
		self.set_collision_mask_value(3, false)
		self.set_collision_mask_value(4, true)
	else:
		self.set_collision_mask_value(3, true)
		self.set_collision_mask_value(4, false)
	
	if is_foreground:
			self.set_deferred("z_index", 1)


func take_damage():
	if is_taking_damage:
		hp -= 1
		#TODO: добавить анимацию получения урона
		if hp <= 0:
			destroy()

#TODO: написать функцию
func destroy(consume := false):
	if (is_destroyable or consume) and !is_destroyed :
		is_destroyed = true
		item_destroyed.emit()
		queue_free()

func set_catched(catch := true):
	if catch:
		self.set_collision_layer_value(3, false)
		self.set_collision_layer_value(4, false)
		self.set_collision_layer_value(5, true)
		set_deferred("freeze", true)
		#freeze = true #TEST 
		#gravity_scale = 0.0
		is_catched = true
		if is_foreground:
			self.set_deferred("z_index", 0)
		item_catched.emit(self)
	else:
		self.set_collision_layer_value(3, !is_foreground)
		self.set_collision_layer_value(4, is_foreground)
		self.set_collision_layer_value(5, false)
		
		set_deferred("freeze", false)
		#gravity_scale = 1.0
		is_catched = false
		if is_foreground:
			self.set_deferred("z_index", 1)
		

func take_impulse(impulse_vector):
	#pickup_body.call_deferred("", Vector2(last_direction_horizontal * force,-100))
	call_deferred("apply_central_impulse", Vector2(impulse_vector[0], impulse_vector[1]))

