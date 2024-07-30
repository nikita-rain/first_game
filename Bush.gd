extends Node2D


var item_path = "res://Scenes/items/red_fruit.tscn"
@onready var scene_item = load(item_path)

var frame_time := 1.0/60.0
var spawn_timer
var spawn_time = 300 * frame_time

func _ready():
	spawn_item() 
	
	spawn_timer = Timer.new()
	spawn_timer.autostart = false
	spawn_timer.one_shot = true
	spawn_timer.wait_time = spawn_time
	add_child(spawn_timer)
	spawn_timer.timeout.connect(_on_spawn_timeout)

func _on_spawn_timeout():
	spawn_item()

func spawn_item():
	var instance: Node2D = scene_item.instantiate()
	self.call_deferred("add_child", instance)
	instance.set_deferred("global_position",  $SpawnPoint.global_position)
	instance.set_deferred("freeze",  true)
	instance.item_destroyed.connect(_on_destroy_item)
	

func _on_destroy_item():
	spawn_timer.start()
