extends Node2D

@export var is_target_podium = false
@export var target_item_name := "battery"
var is_connected = false
@export var connected_active_nodes: Array[Node]
signal update_signal(update_active)

func _ready():
	for node in connected_active_nodes:
		if node.has_method("_on_update_signal"):
			update_signal.connect(node._on_update_signal)

func _on_area_2d_body_entered(body):
	if $ItemPosition.get_child_count() == 0 and !body.is_catched:
		if is_target_podium and "item_name" in body and body.item_name == target_item_name:
			$Sprite2D.play("active")
			update_signal.emit(true)
		body.call_deferred("reparent", $ItemPosition)
		body.set_deferred("global_position", $ItemPosition.global_position)
		#body.call_deferred("set_catched", true)
		body.set_catched(true)
		#body.call_deferred("item_catched.connect", _on_body_catched)
		body.item_catched.connect(_on_body_catched)
		
		#FIXME: сделать тут правильное связывание
#TODO: добавить перемещение позиции

func _on_body_catched(body):
	body.item_catched.disconnect(_on_body_catched)
	$Sprite2D.play("default")
	update_signal.emit(false)
