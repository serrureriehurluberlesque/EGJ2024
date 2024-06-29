extends Personnage

var pre_tasing = false
var tased = false
@onready var j = get_node("../Foule/Joueur")

func _pre_move():
	if not pre_tasing and t > 15.0:
		start_pre_tase()
	if pre_tasing and (j.get_global_position() - get_global_position()).length() < 48:
		start_tase()
		
func _post_move():
	if $TaserTimer.time_left > 0:
		var n = int((1.0 - $TaserTimer.time_left) * 15 / $TaserTimer.wait_time) % len(sprites["taser"])
		$Sprite2D.texture = sprites["taser"][n]

func se_venere():
	$Speaker.speak.emit(randi() % 3 + 1, true, true)
	
func start_pre_tase():
	se_venere()
	pre_tasing = true
	j.not_movable()
	move_to(j.get_global_position() + Vector2(24, 0))

func start_tase():
	if not tased and not $TaserTimer.time_left > 0:
		$TaserTimer.start()
		tased = true
		get_node("/root/Main").next_level(true)
		j.shade_out()
