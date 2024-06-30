extends Node
@export var bubble_scene: PackedScene
signal speak


#var POSSIBLE_SPEECH = ["gŧœng", "Gong gong", "Gong gong gong", "gong gong gong gong gong gong gong gong gong gong gong gong gong gong gong gong gong "]
var SOUP_LETTERS = [
	['$', '§', 'Š', 'Ș', 'ṩ'],
	#['Ǭ', 'Ǿ', 'ʘ', 'Ѻ', 'Ӫ', 'Ỡ', 'ỗ', 'ᾯ', '☺️', '☠️'],
	['Ǭ', 'Ǿ', 'Ỡ', 'ỗ'],
	['Ŭ', 'Ů', 'Ű', 'Ų', 'Ǜ', 'Ṻ', 'Ứ'],
	['Ṕ', 'P'],
]

var last_track_used = -1
var use_track = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_speak(rep, native=false, venere=false):
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
	if get_node("..").is_employee:
		bubble.position.y += 20
		
	if venere:
		bubble.get_node("Bubble").modulate = Color(1.0, 0.0, 0.0)
	
	get_node("..").add_child(bubble)
	if "voices" in get_node("..") and len(get_node("..").voices) > 0:

		var speak_track
		if use_track >= 0:
			speak_track = use_track
			use_track = -1
		else:
			speak_track = randi() % len(get_node("..").voices)
			last_track_used = speak_track
			
		$Voice.stream = get_node("..").voices[speak_track]
		$Voice.play()
	
	for node in $SpeakArea.get_overlapping_bodies():
		if node.is_employee != get_node("..").is_employee:
			node.listen(self, rep)
