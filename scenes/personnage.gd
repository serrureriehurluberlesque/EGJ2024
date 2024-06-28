extends Node2D

@export var SPEED = 100.0

func move(v, delta):
	set_position(get_position() + delta * SPEED * v)
