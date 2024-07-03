extends Personnage

var _blinking_time = 0.0

func _pre_ready():
	for i in 7:
		voices.append(load("res://assets/sounds/voices/%s/%s.wav" % ["JOUEUR", i + 1]))

func _process(delta):
	if $KnockOutTimer.time_left > 0:
		_blinking_time += delta
		if _blinking_time > 0.2:
			if visible:
				hide()
			else:
				show()
			_blinking_time = 0

func _shade_out():
	pass

func is_player():
	return true

func knock_out():
	$KnockOutTimer.start()
	# Make red
	modulate.g = 0
	modulate.b = 0

func _on_knock_out_timer_timeout():
	$Sprite2D.texture = load("res://assets/Chara_death.png")
	is_ko = true
