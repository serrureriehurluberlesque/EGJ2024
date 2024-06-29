extends Personnage

var _blinking_time = 0.0

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
	modulate.g = 0
	modulate.b = 0

func _on_knock_out_timer_timeout():
	# TODO remplacer sprite par sprite_KO
	pass
