extends Node

func _process(delta):
	var directions = {"up": Vector2(0, -1), "down": Vector2(0, 1), "left": Vector2(-1, 0), "right": Vector2(1, 0)}
	
	for d in directions:
		if Input.is_action_pressed("move_" + d):
			get_node("..").move(directions[d], delta)
