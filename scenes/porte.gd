extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	await get_tree().create_timer(0.5).timeout
	
	if get_node("/root/Main").level_number == 1:
		$Area2D/Sprite2D.texture = load("res://assets/door_open_1.png")
		$Area2D/Sprite2D.position.x = -1
	else:
		$Area2D/Sprite2D.texture = load("res://assets/door_open_2.png")
	$PorteOuverteTimer.start()

	if body.is_player():
		if get_node("..").isokpourpasser():
			get_node("/root/Main").next_level()
			remove_body(body)
		else:
			$Area2D/Sprite2D.texture = null
			return
	else:
		remove_body(body)


func remove_body(body):
	body.not_movable()
	body.shade_out()


func _on_porte_ouverte_timer_timeout():
	$Area2D/Sprite2D.texture = null
