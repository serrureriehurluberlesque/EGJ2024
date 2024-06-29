extends Node

var expected_answer: int
var todos = []

func give_todos(ls):
	for l in ls:
		todos.append(l)

func think(time):
	var task
	for todo in todos:
		if todo.t < time:
			task = todos.pop_front()
			break
	return task

#func _ready():
	#pass
	#var target = Vector2(186, 91)
	## get_node("..").move_to(target)

func think_and_answer(source, rep):
	expected_answer = source.get_node("..").expected_response
	$ThinkTimer.start()

func _on_think_timer_timeout():
	get_node("../Speaker").speak.emit(expected_answer, true)
