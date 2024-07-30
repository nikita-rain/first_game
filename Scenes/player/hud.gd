extends Node2D


@export var health := 3
var max_health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass




func _on_player_update_health(hp):
	if !max_health:
		max_health = $HealthBar.get_child_count()
	var health_nodes = $HealthBar.get_children()
	for i in range(0,max_health):
		if i<hp:
			health_nodes[i].animation = "fill"
		else:
			health_nodes[i].animation = "empty"
			
