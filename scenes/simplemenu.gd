extends Sprite2D

var nexted = false
var t = 0
@export var timeout = 3.0

func _process(delta): 
	t += delta
	if t > 1.0:
		if not nexted and Input.is_action_pressed("next") or t > timeout:
			nexted = true
			get_node("/root/Main").fast_next_level()
