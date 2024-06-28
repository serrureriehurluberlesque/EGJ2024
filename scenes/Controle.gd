extends Node

@export var SPEED = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var directions = {"up": Vector2(0, -1), "down": Vector2(0, 1), "left": Vector2(-1, 0), "right": Vector2(1, 0)}
	
	for d in directions:
		if Input.is_action_pressed("move_" + d):
			get_node("..").set_position(get_node("..").get_position() + delta * SPEED * directions[d])
