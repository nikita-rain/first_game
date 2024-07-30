extends Area2D


@export var falling_time_to_damage_msec = 140


#FIXME: добавить проверку стартовой позиции прыжка (если герой начал прыгать ниже платформы то урон не наносится)
func _on_body_entered(body):
	if (body.has_method("take_damage") 
		and body.has_method("get_falling_time_msec") 
		and body.get_falling_time_msec() > falling_time_to_damage_msec):
		body.take_damage()
	elif body.has_method("destroy"):
		body.destroy()
