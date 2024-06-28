extends Node2D

@export var PEOPLE_BEFORE_JOUEUR = 3

var t = 0
var t_next = 5.0
var spawning = true

const scene_joueur = "res://scenes/joueur.tscn"
const scene_extra = "res://scenes/extra.tscn"

var extras = []
var joueur

# Called when the node enters the scene tree for the first time.
func _ready():
	var n = PEOPLE_BEFORE_JOUEUR + 1
	$Sol.set_position(Vector2(0, 16 * n - 32))
	$Sol.set_scale(Vector2(1, n))
	
	for i in PEOPLE_BEFORE_JOUEUR:
		var extra = preload(scene_extra).instantiate()
		extra.set_position(get_position() + Vector2(0, i * 32))
		extra.can_move = false
		extras.append(extra)
		add_child(extra)
	
	joueur = preload(scene_joueur).instantiate()
	joueur.set_position(get_position() + Vector2(0, PEOPLE_BEFORE_JOUEUR * 32))
	joueur.can_move = false
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
