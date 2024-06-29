extends Personnage

var pre_tasing = false

func _pre_move():
	if not pre_tasing and t > 7.0:
		start_pre_tase()
	if pre_tasing and not moving:
		start_tase()

func _post_move():
	if $TaserTimer.time_left > 0:
		
		$Sprite2D.texture = sprites["tase"][int(1 - $ShadeOutTimer.time_left * 3)]

func start_pre_tase():
	pre_tasing = true
	move_to(get_node("../Foule/Joueur").get_global_position() + Vector2(24, 0))

func start_tase():
	pass
	


func _on_taser_timer_timeout():
	get_node("/root/Main").next_level()
