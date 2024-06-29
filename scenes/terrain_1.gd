extends Terrain

func get_todos():
	return [
		{"t": 0.1, "action": "move", "target": Vector2(140, 160)},
		{"t": 0.8, "action": "move", "target": Vector2(193, 140)},
		{"t": 3.0, "action": "move", "target": Vector2(186, 91)},
		]
