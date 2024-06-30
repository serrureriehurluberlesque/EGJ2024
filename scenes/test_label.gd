extends Node2D


var ini = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not ini:
		init()
	else:
		pass

func init():
	ini = true
	for i in 22:
		for j in 12:
			var l = load("res://scenes/extra.tscn").instantiate()
			l.position = Vector2(90 * i, 100 * j)
			add_child(l)
			l.get_node("Speaker").speak.emit(randi() % 3 + 1, true)
