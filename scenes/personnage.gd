extends Node2D

@export var SPEED = 100.0
@onready var bubble_scene = preload("res://scenes/speech_bubble.tscn")

@export var sprite_name = "Chara"

var can_move = true
var t = 0
var moving = false
var sprites_walk = []

func _ready():
	$Sprite2D.texture = load("res://assets/" + sprite_name + "_idle.png")
	for i in 4:
		sprites_walk.append(load("res://assets/" + sprite_name + "_walk_front_" + str(i + 1) + ".png"))

func _process(delta):
	t += delta
	if moving:
		animate_move()
	moving = false

func animate_move():
	$Sprite2D.texture = sprites_walk[int(t * 6) % 4]

func speak():
	# Create a new instance of the SpeechBubble scene.
	var bubble = bubble_scene.instantiate()
	bubble.text = "Un ou deux mots"
	bubble.position = Vector2(0, -110)
	
	add_child(bubble)

func movable():
	can_move = true
	speak()

func move(v, delta):
	if can_move:
		set_position(get_position() + delta * SPEED * v)
		moving = true
