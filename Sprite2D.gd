extends Sprite2D

var nexted = false

func _process(delta): 
	if not nexted and Input.is_action_pressed("next"):
		print(nexted)
		nexted = true
		get_node("/root/Main").fast_next_level()
