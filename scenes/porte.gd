extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	await get_tree().create_timer(0.5).timeout
	if body.is_player():
		if get_node("..").isokpourpasser():
			get_node("/root/Main").next_level()
			remove_body(body)
		else:
			return
	else:
		remove_body(body)
		

func remove_body(body):
	body.not_movable()
	body.shade_out()
