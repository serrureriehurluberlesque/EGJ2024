extends StaticBody2D

@export var emp_type: int
@export var is_plus: bool
var expected_response = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	var plus = "_plus" if is_plus else ""
	var p = "res://assets/Employee_" + str(emp_type) + plus + ".png"
	
	if ResourceLoader.exists(p):
		$Sprite2D.texture = load(p)

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
