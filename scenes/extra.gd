extends Personnage

func _pre_ready():
	sprite_name += "_" + str(randi() % 2 + 1)

func _shade_out():
	queue_free()

func listen(source, rep):
	if source != $Speaker:
		$IA.think_and_answer(source, rep)
