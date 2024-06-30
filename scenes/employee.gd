extends StaticBody2D

@export var emp_type: int
@export var is_plus: bool
@onready var randomed = randi() % 2
var expected_response = 0
var waiting_for_answer = false
var given_response = []

var is_employee = true
var is_content = false
var voices = []
func is_player():
	return false

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 7:
		voices.append(load("res://assets/sounds/voices/%s/%s.wav" % ["ROBOTO", i + 1]))
	
	var plus = "_plus" if is_plus else ""
	var p = "res://assets/Employee_" + str(emp_type) + plus + ".png"
	
	if ResourceLoader.exists(p):
		$Sprite2D.texture = load(p)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if waiting_for_answer == false:
		if body.is_player():
			waiting_for_answer = true
		if emp_type == 1:
			var delta = 0
			if is_plus:
				if randomed > 0.5:
					delta = 1
				else:
					delta = -1
			
			var rep = randi() % 3 + 1
			if rep + delta > 3:
				rep -= 1
			if rep + delta < 1:
				rep += 1
			
			expected_response = rep + delta
				
			$Speaker.speak.emit(rep, true)
			$ValidationTimer.start()
		elif emp_type == 2:
			if is_plus:
				var rep = [randi() % 3 + 1, randi() % 3 + 1, randi() % 3 + 1]
				expected_response = rep
				$ValidationTimer.wait_time = 12
				$ValidationTimer.start()
				$Speaker.speak.emit(rep[0], true)
				await get_tree().create_timer(1.1).timeout
				$Speaker.speak.emit(rep[1], true)
				await get_tree().create_timer(1.1).timeout
				$Speaker.speak.emit(rep[2], true)
			else:
				var rep = [randi() % 3 + 1, randi() % 3 + 1]
				expected_response = rep
				$ValidationTimer.wait_time = 10
				$ValidationTimer.start()
				$Speaker.speak.emit(rep[0], true)
				await get_tree().create_timer(1.5).timeout
				$Speaker.speak.emit(rep[1], true)
		else:
			pass

func listen(source, rep):
	var node = source.get_node("..")
	if node.is_player():
		if typeof(expected_response) == TYPE_INT:
			if rep != expected_response: # TODO pas forcément identité
				#print("WRONG (%d != %d)" % [rep, expected_response])
				get_node("..").osekour()
				se_venere()
			else:
				#print("CORRECT")
				expected_response = 0
				waiting_for_answer = false
				is_content = true
		else:
			given_response.append(rep)
			if len(given_response) == len(expected_response):
				if given_response != expected_response: # TODO pas forcément identité
					#print("WRONG (%d != %d)" % [given_response, expected_response])
					get_node("..").osekour()
					se_venere()
					given_response = []
				else:
					#print("CORRECT")
					expected_response = 0
					waiting_for_answer = false
					given_response = []
					is_content = true

	$ValidationTimer.stop()

func _on_validation_timer_timeout():
	#print("WRONG (timer timeout!)")
	get_node("..").osekour()
	se_venere()
	
func se_venere():
	$Speaker.speak.emit(randi() % 3 + 1, true, true)
