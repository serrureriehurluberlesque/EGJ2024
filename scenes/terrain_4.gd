extends Terrain

func get_todos():
	var middle = Vector2(176, 128)
	return [
		{"t": 0.1, "action": "move", "target": Vector2(-106, 90) + middle},
		{"t": 0.9, "action": "move", "target": Vector2(-64, 12) + middle},
		{"t": 7.7, "action": "move", "target": Vector2(40, 12) + middle},
		{"t": 15.7, "action": "move", "target": Vector2(125, 08) + middle},
		{"t": 18.2, "action": "move", "target": Vector2(125, -80) + middle},
		]
