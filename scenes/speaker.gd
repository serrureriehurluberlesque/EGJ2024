extends Node
@export var bubble_scene: PackedScene
signal speak


#var POSSIBLE_SPEECH = ["gŧœng", "Gong gong", "Gong gong gong", "gong gong gong gong gong gong gong gong gong gong gong gong gong gong gong gong gong "]
var SOUP_LETTERS = [
	['$', '§', 'Š', 'Ƨ', 'Ș', 'Σ', '₴', 'ȿ', 'σ', 'ṩ'],
	['Ǭ', 'Ǿ', 'ʘ', 'Ѻ', 'Ӫ', 'Ỡ', 'ỗ', 'ᾯ', '☺️', '☠️'],
	['Ŭ', 'Ů', 'Ű', 'Ų', 'Ǜ', 'Џ', 'Ṻ', 'Ứ', 'ῧ', 'ﬠ', 'ʋ'],
	['Ƥ', 'ϥ', 'Ҏ', 'ᵽ', 'Ṕ', 'Ṗ', 'ῤ', 'Ῥ', '₱', 'Ᵽ'],
]
var POSSIBLE_SPEECH = ["gŧœng", "Gong gong", "Gong gong gong", "gong gong gong gong gong gong gong gong gong gong gong gong gong gong gong gong gong "]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_speak(rep, native=false):
	var words = ""
	
	for n in rep:
		var new_word = ""
		if native:
			for letter in SOUP_LETTERS:
				new_word += letter[randi() % letter.size()]
		else:
			new_word = "soup"
			
		new_word += " "
			
		words += new_word
	# Create a new instance of the SpeechBubble scene.alias
	var bubble = bubble_scene.instantiate()
	#bubble.get_node("Text").text = POSSIBLE_SPEECH[randi() % POSSIBLE_SPEECH.size()]
	bubble.get_node("Text").text = words
	bubble.position = Vector2(0, - (get_node("../Sprite2D").texture.get_height() + bubble.size.y + 3))
	if venere:
		bubble.get_node("Bubble").modulate = Color(1.0, 0.0, 0.0)
	
	get_node("..").add_child(bubble)
	
	for node in $SpeakArea.get_overlapping_bodies():
		if node.is_employee != get_node("..").is_employee:
			node.listen(self, rep)
