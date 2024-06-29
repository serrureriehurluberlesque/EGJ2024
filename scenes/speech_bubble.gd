extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$FadeInTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $FadeInTimer.time_left > 0:
		modulate.a = cos($FadeInTimer.time_left * (PI / 2) / $FadeInTimer.wait_time)
	elif $FadeOutTimer.time_left > 0:
		modulate.a = sin($FadeOutTimer.time_left * (PI / 2) / $FadeOutTimer.wait_time)

func _on_fade_in_timer_timeout():
	var var_time = 0.2 + $Text.text.length() * 0.06 # TODO adapter
	$SpeechTimer.wait_time = var_time
	$SpeechTimer.start()

func _on_speech_timer_timeout():
	$FadeOutTimer.start()

func _on_fade_out_timer_timeout():
	hide()
	queue_free()


