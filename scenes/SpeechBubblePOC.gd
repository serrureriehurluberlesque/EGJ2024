extends Node

@export var bubble_scene: PackedScene
signal speak

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnBubbleButton.position = $SpawnBubbleButton/Marker2D.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var RANDOM_TEXT = ["Bonjour, jeune aventurier !", "Blip blap bloup", "heyyyy", "Some other random text", "Un texte plutôt long qui risque de faire plusieurs lignes"]

func _on_spawn_bubble_button_pressed():
	var little_bit_higher = $SpawnBubbleButton/Marker2D.position
	little_bit_higher.y -= 150
	speak.emit(little_bit_higher)


func _on_speak(pos):
	# Create a new instance of the SpeechBubble scene.
	var bubble = bubble_scene.instantiate()
	bubble.text = RANDOM_TEXT[randi() % RANDOM_TEXT.size()]
	bubble.position = pos
	
	add_child(bubble)
