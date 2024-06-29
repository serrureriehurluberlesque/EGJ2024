extends Personnage

func _shade_out():
	queue_free()

func listen(source, rep):
	if source != $Speaker:
		$IA.think_and_answer(source, rep)
