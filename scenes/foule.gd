extends Node2D

@export var PEOPLE_BEFORE_JOUEUR = 3

var t = 0
@export var t_next = 3.5
var t_avance = 0.0
var spawning = true
var watched = true

const scene_joueur = "res://scenes/joueur.tscn"
const scene_extra = "res://scenes/extra.tscn"

var extras = []
var joueur
var expected_jpos: Vector2
var todos = []
# Called when the node enters the scene tree for the first time.

func _ready():
	todos = get_node("..").get_todos()
	var n = PEOPLE_BEFORE_JOUEUR + 1
	$Sol.set_position(Vector2(32 * n, -16))
	$Sol.set_scale(Vector2(n, 1))
	
	for i in PEOPLE_BEFORE_JOUEUR:
		var extra = preload(scene_extra).instantiate()
		extra.not_movable()
		extra.set_position(Vector2(i * 32, 0))
		extra.get_node("IA").give_todos(todos)
		extras.append(extra)
		add_child(extra)
	
	joueur = preload(scene_joueur).instantiate()
	#joueur.not_movable() TODO : seulement dès que contrôles montrés ??
	expected_jpos = Vector2(PEOPLE_BEFORE_JOUEUR * 32, 0)
	joueur.set_position(expected_jpos)
	add_child(joueur)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawning:
		t += delta
		if t > t_next:
			next()
			t -= t_next
			expected_jpos = Vector2(extras.size() * 32, 0)
		elif not watched and t > 2 * t_next / 3:
			var root = get_node("/root/Main")
			if root.level_number == 1:
				root.get_node("Level1/Center/Salle/SubViewportContainer/SubViewport/Terrain").show_go()
			
	if t_avance > 0:
		t_avance -= delta
		var SPEED = 40
		for e in extras:
			e.apply_central_force(SPEED * 10 * Vector2(-1, 0))
		#joueur.apply_central_force(SPEED * 10 * Vector2(-1, 0))
	if watched:
		var diff = joueur.get_global_transform().origin - (get_global_transform().origin + expected_jpos)
		if diff.length() > 48:
			get_node("..").osekour()
			for e in extras:
				e.se_venere()
			watched = false

func next():
	var suivant = extras.pop_front()
	if not suivant:
		suivant = joueur
		spawning = false

	elif not extras:
		watched = false
	
	suivant.movable()
	if suivant != joueur:
		t_avance = 0.82
		
