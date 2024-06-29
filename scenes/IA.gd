extends Node

func _ready():
	var target = Vector2(186, 91)
	get_node("..").move_to(target)
