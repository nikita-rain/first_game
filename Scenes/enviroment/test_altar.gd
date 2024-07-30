extends StaticBody2D

var world_node: Node

#FIXME: оптимизировать способ загрузки

var convert_list = {
	"item_box": "res://Scenes/items/key.tscn",
	"frog": "res://Scenes/items/red_fruit.tscn" #TODO: сделать предмет с активкой лягушки
}
#TODO: сделать в виде ресурса

var frame_time := 1.0/60.0
var convert_timer
var convert_time = 120 * frame_time

var is_converting = false

#TODO: сделать обьект с списком всех обьектов и спиосок крафтов добавить в этот файл и скрипт преобразования
# Called when the node enters the scene tree for the first time.
func _ready():
	convert_timer = Timer.new()
	convert_timer.autostart = false
	convert_timer.one_shot = true
	convert_timer.wait_time = convert_time
	add_child(convert_timer)
	convert_timer.timeout.connect(_on_convert_timeout)
	pass # Replace with function body.


func _on_convert_timeout():
	if is_converting:
		is_converting = false
		convert_item()

func convert_item():
	if $Area2D.has_overlapping_bodies():
		var body_list: Array[Node2D] = $Area2D.get_overlapping_bodies()
		if (body_list.size() == 1) and ("item_name" in body_list[0]):
			#TODO: добавить проверку на крафты
			if body_list[0].item_name in convert_list:
				var scene_path = convert_list[body_list[0].item_name]
				body_list[0].queue_free()
				var scene = load(scene_path)
				var instance = scene.instantiate()
				if !world_node:
					world_node = get_parent()
					if !world_node: return
				
				add_child(instance) #FIXME: возможно это лишнее
				instance.global_position = $SpawnNode.global_position
				instance.reparent(world_node)

func _on_area_2d_body_entered(_body):
	check_valid_to_convert()

func _on_area_2d_body_exited(_body):
	check_valid_to_convert()

func check_valid_to_convert():
	if !is_converting and is_valid_to_convert():
		is_converting = true
		convert_timer.start(convert_time)
	elif is_converting and !is_valid_to_convert():
		is_converting = false

func is_valid_to_convert():
	if !$Area2D.has_overlapping_bodies():
		return false
	var body_list: Array[Node2D] = $Area2D.get_overlapping_bodies() #FIXME: я правильно указал тип?
	if body_list.size() > 1:
		return false
	if "item_name" in body_list[0]:
		return true
	
