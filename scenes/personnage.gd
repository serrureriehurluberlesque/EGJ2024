extends Node2D

@export var SPEED = 100.0
@onready var bubble_scene = preload("res://scenes/speech_bubble.tscn")

@export var sprite_name = "Chara"

var can_move = true
var t = 0
var moving = false
var sprites_walk = {Vector2(0, -1): [], Vector2(0, 1): [], Vector2(-1, 0): [], Vector2(1, 0): []}
var sprites_idle = []
var move_target = null

func _ready():
	sprites_idle.append(load("res://assets/" + sprite_name + "_idle.png"))
	
	var directions = {Vector2(0, -1): "_walk_back_", Vector2(0, 1): "_walk_front_", Vector2(-1, 0): "_walk_side_", Vector2(1, 0): "_walk_side_"}
	for n in directions:
		for i in 4:
			var text = load("res://assets/" + sprite_name + directions[n] + str(i + 1) + ".png")
			sprites_walk[n].append(text)
	
	$Sprite2D.texture = sprites_idle[0]

func _process(delta):
	t += delta
	if move_target:
		var dpos = move_target - get_global_position()
		
		if dpos.x > SPEED * delta:
			move(Vector2(1, 0), delta)
		if dpos.x < -1 * SPEED * delta:
			move(Vector2(-1, 0), delta)
		if dpos.y > SPEED * delta:
			move(Vector2(0, 1), delta)
		if dpos.y < -1 * SPEED * delta:
			move(Vector2(0, -1), delta)
		if can_move and not moving:
			move_target = null
	if not moving:
		animate_move()
	else:
		animate_move(moving)
	moving = false

func animate_move(d=Vector2(0, 0)):
	if d:
		$Sprite2D.texture = sprites_walk[d][int(t * 6) % 4]
		if d == Vector2(1, 0):
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
	else:
		$Sprite2D.texture = sprites_idle[int(t * 6) % 1]

func movable():
	can_move = true
	$Speaker.speak.emit()

func move(v, delta):
	if can_move:
		set_position(get_position() + delta * SPEED * v)
		moving = v

func move_to(pos):
	if pos == Vector2(0, 0):
		print("Warning pos 0,0 ça va foutre la merde")
	move_target = pos
