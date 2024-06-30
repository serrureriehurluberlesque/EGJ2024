extends Sprite2D

@export var togglage = false
@export var loop = false

var nexted = false
var t = 0

var sprites = []

func _ready():
	for i in 6:
		var p = "res://assets/titlescreen_" + str(i) + ".png"
		if ResourceLoader.exists(p):
			sprites.append(load(p))

func _process(delta): 
	t += delta
	if t > 1.0:
		if togglage:
			var delt = 0
			var m = 2
			if not loop: # soucoupe
				delt = 2
				m = 4
			texture = sprites[(int(t * m / 2) % m) + delt]

		if not nexted and Input.is_action_pressed("next"):
			nexted = true
			if loop:
				get_node("/root/Main").level_number = -1
			get_node("/root/Main").fast_next_level()
