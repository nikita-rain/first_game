extends StaticBody2D


var is_fired = false

#FIXME: добавить минимальное время между выстрелами

func _on_projectile_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage()
	$Projectile.sleep_projectile()
	is_fired = false
	
	if $"Agr Area".has_overlapping_bodies():
		$"Agr Area".emit_signal("body_entered", $"Agr Area".get_overlapping_bodies()[0])
	
func _on_agr_area_body_entered(_body):
	if !is_fired:
		is_fired = true
		$Projectile.unsleep_projectile()
	
	
