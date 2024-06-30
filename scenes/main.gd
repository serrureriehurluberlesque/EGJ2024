extends Control

var level

var level_number = 4
var to_next = false

# Called when the node enters the scene tree for the first time.
func _ready():
	load_next_level() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if to_next:
		to_next = false
		load_next_level()

func door_sound():
	$DoorSound.play()
	
func next_level(dead=false):
	if dead:
		$DeathSound.play()
	else:
		$DoorSound.play()
		level_number += 1
	$NextLevelTimer.start()
	
func _on_next_level_timer_timeout():
	load_next_level()
	
func get_current_level():
	return "res://scenes/level_%d.tscn" % level_number

func fast_next_level():
	level_number += 1
	to_next = true

func load_next_level():
	if level:
		level.free()
	level = load(get_current_level()).instantiate()
	add_child(level)
