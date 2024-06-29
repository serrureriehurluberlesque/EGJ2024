extends Label

var coords_bubble_left : Array = [
	[ 1.0, 3.0 ],  [ 1.0, 2.0 ], # bas de la bulle
	[ 1.0, 2.0 ], [ 0.0, 1.0 ], # bas-milieu de la bulle
	[ 0.0, 1.0 ],  [ 1.0, 0.0 ], # milieu-haut de la bulle
	[ 1.0, 0.0 ], [ 4.0, 0.0 ], # haut de la bulle
	[ 4.0, 0.0 ], [ 5.0, 1.0 ], # haut-milieu de la bulle
	[ 5.0, 1.0 ], [ 4.0, 2.0 ], # milieu-bas de la bulle
	[ 4.0, 2.0 ],  [ 2.0, 2.0 ], # bas de la bulle
	[ 2.0, 2.0 ],  [ 1.0, 3.0 ], # bas de la bulle
]
var bubble_left : PackedVector2Array

func float_array_to_Vector2Array(coords : Array) -> PackedVector2Array:
	# Convert the array of floats into a PackedVector2Array.
	var array : PackedVector2Array = []
	#var n = get_node("../Text").text.split(" ").size() - 1
	var n = get_node("../Text").get_line_count()
	
	for coord in coords:
		var vec = Vector2(coord[0], coord[1])
		
		# Scale bubble
		if n >= 2:
			get_node("../Text").position.y -= (n - 1)  # oui c'est moche...
			if vec.y == 1.0:
				vec.y -= 0.5 * (n - 1)
			elif vec.y < 1.0:
				vec.y -= 1 * (n - 1)
				
		array.append(vec * 12)

	return array

# Called when the node enters the scene tree for the first time.
func _ready():
	bubble_left = float_array_to_Vector2Array(coords_bubble_left);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	draw_polygon(bubble_left, [ Color.WHITE ])
