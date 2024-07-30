extends StaticBody2D


signal key_recieved

func _on_area_2d_body_entered(body):
	if "item_name" in body and body.item_name == "golden_key":
		body.queue_free()
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		key_recieved.emit()
