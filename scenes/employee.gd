extends StaticBody2D

var expected_response = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	var rep = randi() % 3 + 1
	$Speaker.speak.emit(rep, true)
	expected_response = rep
	$ValidationTimer.start()

func listen(source, rep):
	if source != $Speaker:
		if rep != expected_response: # TODO pas forcément identité
			print("WRONG (%d != %d)" % [rep, expected_response])
		else:
			print("CORRECT")
			$ValidationTimer.stop()
			expected_response = 0


func _on_validation_timer_timeout():
	print("WRONG (timer timeout!)")
	expected_response = 0
