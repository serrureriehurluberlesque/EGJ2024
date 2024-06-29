extends Node2D

@export var PEOPLE_BEFORE_JOUEUR = 3

var t = 0
var t_next = 0.7
var spawning = true

const scene_joueur = "res://scenes/joueur.tscn"
const scene_extra = "res://scenes/extra.tscn"

var extras = []
var joueur

# Called when the node enters the scene tree for the first time.
func _ready():
	var n = PEOPLE_BEFORE_JOUEUR + 1
	$Sol.set_position(Vector2(32 * n, -16))
	$Sol.set_scale(Vector2(n, 1))
	
	for i in PEOPLE_BEFORE_JOUEUR:
		var extra = preload(scene_extra).instantiate()
		extra.not_movable()
		extra.set_position(Vector2(i * 32, 0))
		extras.append(extra)
		add_child(extra)
	
	joueur = preload(scene_joueur).instantiate()
	joueur.not_movable()
	joueur.set_position(Vector2(PEOPLE_BEFORE_JOUEUR * 32, 0))
	add_child(joueur)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawning:
		t += delta
		if t > t_next:
			next()
			t -= t_next

func next():
	var suivant = extras.pop_front()
	if not suivant:
		suivant = joueur
		spawning = false
	
	suivant.movable()
