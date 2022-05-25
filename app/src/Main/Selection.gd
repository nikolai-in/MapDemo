extends State

onready var tree: = get_node("../../UI/Sidebar/ScrollContainer/Column/Editor/Margin/Column/Layers/Tree")

var selection = []


func _on_Tree_multi_selected(item: TreeItem, column: int, selected: bool) -> void:
	_state_machine.transition_to("Selection")
	var origin = item.get_metadata(column)
	if origin is Polygon2D:
		if selected:
			origin.self_modulate = Color( 2, 2, 2, 0.99 )
			selection.append(origin)
		else:
			origin.self_modulate = Color( 1, 1, 1, 1 )
			selection.remove(selection.find(origin))
	print_debug(selection)


func enter(msg: Dictionary = {}) -> void:
	for btn in get_node("../Viewer").buttons:
		btn.pressed = false
	for btn in get_node("../../UI/Sidebar/ScrollContainer/Column/Editor/Margin/Column/Bools").get_children():
		btn.disabled = false


func exit() -> void:
	for btn in get_node("../../UI/Sidebar/ScrollContainer/Column/Editor/Margin/Column/Bools").get_children():
		btn.disabled = true


func unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
					print_debug("VIEWER")
					_state_machine.transition_to("Viewer")


func _on_Unite_pressed() -> void:
	pass # Replace with function body.


func _on_Subtract_pressed() -> void:
	pass # Replace with function body.


func _on_Intersect_pressed() -> void:
	pass # Replace with function body.


func _on_Exclude_pressed() -> void:
	pass # Replace with function body.
