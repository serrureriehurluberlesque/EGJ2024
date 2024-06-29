extends Node
@export var bubble_scene: PackedScene
signal speak

var POSSIBLE_SPEECH = ["gONG", "Gong gong", "Gong gong gong", "gong gong gong gong gong gong gong gong gong gong gong gong gong gong gong gong gong "]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_speak():
	# Create a new instance of the SpeechBubble scene.alias
	var bubble = bubble_scene.instantiate()
	bubble.text = POSSIBLE_SPEECH[randi() % POSSIBLE_SPEECH.size()]
	bubble.position = Vector2(0, - (get_node("../Sprite2D").texture.get_height() + bubble.size.y + 3))

	
	get_node("..").add_child(bubble)
