class_name Portal extends Node2D


@export var linked_portal: Portal

var frame_time := 1.0/60.0
@export var teleport_time = 120 * frame_time
var teleport_timer: Timer
var item_catched = false

#TODO: Добавить анимацию телепортации 
func _ready():
	teleport_timer = Timer.new()
	teleport_timer.autostart = false
	teleport_timer.one_shot = true
	teleport_timer.wait_time = teleport_time
	add_child(teleport_timer)
	teleport_timer.timeout.connect(_on_teleport_timeout)

func _on_teleport_timeout():
	if linked_portal and !linked_portal.item_catched:
		linked_portal.take_teleported_item($ItemPosition.get_children()[0])
	$Sprite2D.play("default")
		

func take_teleported_item(item: Item):
	item.call_deferred("reparent", $ItemPosition)
	item.set_deferred("global_position", $ItemPosition.global_position)
	item.set_catched(true)
	item.item_catched.connect(_on_body_catched) #FIXME: заменить на функцию
	item_catched = true

func _on_area_2d_body_entered(item: Item):
	if $ItemPosition.get_child_count() == 0 and !item.is_catched: #FIXME: заменить на item_catched
		item.call_deferred("reparent", $ItemPosition)
		item.set_deferred("global_position", $ItemPosition.global_position)
		item.set_catched(true)
		item.item_catched.connect(_on_body_catched)
		item_catched = true
		teleport_timer.start()
		$Sprite2D.play("active")

func _on_body_catched(body):
	body.item_catched.disconnect(_on_body_catched)
	item_catched = false
	$Sprite2D.play("default")
