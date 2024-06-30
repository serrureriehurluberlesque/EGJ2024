extends Sprite2D

var t = 0
var t2 = 0
var seuil = 0.05
var x = 5
var y = 4
var tab = []
var ended = false

var timeout = 20.0
# Called when the node enters the scene tree for the first time.

func get_todos():
	return []

func _ready():
	$Foule.free()
	$Garde.free()
	$Porte.free()
	
	for i in x:
		tab.append([])
		for j in y:
			var l = load("res://scenes/extra.tscn").instantiate()
			l.position = Vector2(63 * i, 44 * j) + Vector2(-126, -42) + Vector2(randi() % 20 - 10, randi() % 20 - 10)
			add_child(l)
			tab[i].append(l)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	t2 += randf() * randf() * randf() * delta
	if t2 > seuil:
		t2 -= seuil 
		tab[randi() % x][randi() % y].get_node("Speaker").speak.emit(randi() % 3 + 1, true)
		
	if t > timeout and not ended:
		print("ending")
		ended = true
