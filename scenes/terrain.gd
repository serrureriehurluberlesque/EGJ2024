extends Sprite2D
class_name Terrain

func get_todos():
	return [{"t": 1.2, "action": "move", "target": Vector2(186, 91)}]
	
func osekour():
	print("OSEKOUUR")
	$Garde.start_pre_tase()

func isokpourpasser():
	if loop_employee():
		return true
	else:
		osekour()
		print("NOT OK")
		return false

func loop_employee():
	var all_contents = true
	for child in get_children():
		if "is_employee" in child and child.is_employee:
			if not child.is_content:
				all_contents = false
				child.se_venere()
	return all_contents
