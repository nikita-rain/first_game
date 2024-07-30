extends RigidBody2D

@export var vel_x = -80.0

var pos

func _ready():
	sleep_projectile()


func sleep_projectile():
	if !pos:
		pos = get_parent().get_node("ProjectileStart").global_position
	
	global_position.x = pos.x
	global_position.y = pos.y
	linear_velocity.x = 0
	
	
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.hide()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	



func unsleep_projectile():
	if !pos:
		pos = get_parent().get_node("ProjectileStart").global_position
	
	global_position.x = pos.x
	global_position.y = pos.y
	linear_velocity.x = vel_x
	
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D.show()
	

	

