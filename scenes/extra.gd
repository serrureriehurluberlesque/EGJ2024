extends Personnage

func _pre_ready():
	var alien_id = randi() % 3 + 1
	sprite_name += "_" + str(alien_id)
	
	var voice_matching = {1: "KUSOJIJI", 2: "MIMOU", 3: "SATAN"}
	
	for i in 7:
		voices.append(load("res://assets/sounds/voices/%s/%s.wav" % [voice_matching[alien_id], i + 1]))

func _shade_out():
	queue_free()

func listen(source, rep):
	if source != $Speaker:
		$IA.think_and_answer(source, rep)
