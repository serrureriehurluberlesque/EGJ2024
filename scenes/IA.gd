extends Node

func _process(delta):
	get_node("..").move(Vector2(1, 0), delta)
