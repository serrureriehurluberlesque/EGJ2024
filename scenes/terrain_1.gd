extends Terrain

var show_go_texture1 = load("res://assets/Tableau2_go_1.png")
var show_go_texture2 = load("res://assets/Tableau2_go_2.png")
var _blinking_time = 0.0

func _ready():
	$InitTimer.start()

func _process(delta):
	if $ShowGoTimer.time_left > 0:
		_blinking_time += delta
		if _blinking_time > 0.4:
			if texture == show_go_texture1:
				texture = show_go_texture2
			else:
				texture = show_go_texture1
			_blinking_time = 0

func show_go():
	$ShowGoTimer.start()

func get_todos():
	return [
		{"t": 0.1, "action": "move", "target": Vector2(140, 160)},
		{"t": 0.8, "action": "move", "target": Vector2(193, 140)},
		{"t": 3.5, "action": "move", "target": Vector2(186, 91)},
		]


func _on_show_go_timer_timeout():
	texture = load("res://assets/Tableau1.png")


func _on_init_timer_timeout():
	texture = load("res://assets/Tableau2_tuto.png")
