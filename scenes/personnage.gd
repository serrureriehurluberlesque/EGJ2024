extends Node2D

@export var SPEED = 100.0

var can_move = true

func move(v, delta):
	if can_move:
		set_position(get_position() + delta * SPEED * v)
