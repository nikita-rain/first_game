extends Line2D

@onready var wire_on: Texture = load("res://Assets/Texture/Items/WireOn.png")
@onready var wire_off: Texture = load("res://Assets/Texture/Items/WireOff.png")


func _on_update_signal(update_active:bool):
	if update_active:
		self.texture = wire_on
	else:
		self.texture = wire_off
