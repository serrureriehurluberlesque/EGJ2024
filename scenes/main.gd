extends Control

var level

# Called when the node enters the scene tree for the first time.
func _ready():
	load_next_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func next_level():
	$DoorSound.play()

func _on_door_sound_finished():
	load_next_level()

func load_next_level():
	if level:
		level.free()
	level = preload("res://scenes/level.tscn").instantiate()
	add_child(level)
