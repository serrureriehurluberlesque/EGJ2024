extends Control

var level

var level_number = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	load_next_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func next_level(dead=false):
	if dead:
		$DeathSound.play()
	else:
		$DoorSound.play()

func _on_door_sound_finished():
	level_number += 1
	load_next_level()

func _on_death_sound_finished():
	load_next_level()
	
func load_next_level():
	if level:
		level.free()
	level = load("res://scenes/level_" + str(level_number) + ".tscn").instantiate()
	add_child(level)


