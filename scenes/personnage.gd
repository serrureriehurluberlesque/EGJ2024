extends RigidBody2D
class_name Personnage

@export var SPEED = 100.0
@onready var bubble_scene = preload("res://scenes/speech_bubble.tscn")

@export var sprite_name = "Chara"

var can_move = true
var t = 0
var moving = false
var sprites = {}
var direction_walk = {Vector2(0, -1): "walk_back", Vector2(0, 1): "walk_front", Vector2(-1, 0): "walk_side", Vector2(1, 0): "walk_side"}
var move_target = null
var is_employee = false

func _ready():
	var list_sprite_names = ["taser", "idle"]
	var unique = []
	for d in direction_walk.values():
		if not unique.has(d):
			unique.append(d)
			
	for d in unique:
		list_sprite_names.append(d)
		
	for lsn in list_sprite_names:
		sprites[lsn] = []
		for i in 4:
			var p = "res://assets/" + sprite_name + "_" + lsn + "_" + str(i + 1) + ".png"
			if ResourceLoader.exists(p):
				sprites[lsn].append(load(p))
				
	animate_move()

func _process(delta):
	pass
	
func _physics_process(delta):
	t += delta
	
	_pre_move()
	
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
	
	_post_move()
	
	if $ShadeOutTimer.time_left > 0:
		modulate.a = sin($ShadeOutTimer.time_left * (PI / 2) / $ShadeOutTimer.wait_time)
	
func _pre_move():
	pass

func _post_move():
	pass
	
func animate_move(d=Vector2(0, 0)):
	if d and sprites[direction_walk[d]]:
		$Sprite2D.texture = sprites[direction_walk[d]][int(t * 6) % len(sprites[direction_walk[d]])]
		if d == Vector2(1, 0):
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
	else:
		$Sprite2D.texture = sprites["idle"][int(t * 6) % len(sprites["idle"])]

func not_movable():
	can_move = false
	
func movable():
	can_move = true

func move(v, delta):
	if can_move:
		# set_position(get_position() + delta * SPEED * v)
		apply_central_force(SPEED * 10 * v)
		moving = v

func move_to(pos):
	if pos == Vector2(0, 0):
		print("Warning pos 0,0 ça va foutre la merde")
	move_target = pos

func shade_out():
	$ShadeOutTimer.start()

func _on_shade_out_timer_timeout():
	hide()
	_shade_out()

func _shade_out():
	pass

func is_player():
	false

func listen(source, rep):
	if source != $Speaker:
		print("I'm personnally listening")
