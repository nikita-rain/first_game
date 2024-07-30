extends StaticBody2D


func _on_key_hole_key_recieved():
	#TODO: добавить анимацию и звук
	$Sprite2D.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
