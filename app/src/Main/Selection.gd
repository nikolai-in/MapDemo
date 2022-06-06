extends State

onready var tree: = get_node("../../UI/Sidebar/ScrollContainer/Column/Editor/Margin/Column/Layers/Tree")

var selection = []


func _on_Tree_multi_selected(item: TreeItem, column: int, selected: bool) -> void:
	_state_machine.transition_to("Selection")
	if is_instance_valid(item.get_metadata(column)):
		var origin = item.get_metadata(column)
		if is_instance_valid(origin) && origin is Polygon2D:
			if selected:
				# print("\n1111111111\n", origin, selected, "\n1111111111\n")
				origin.self_modulate = Color( 2, 2, 2, 0.99 )
				selection.append(origin)
			else:
				# print("\n000000000000\n", origin, selected, "\nn000000000000\n")
				origin.self_modulate = Color( 1, 1, 1, 1 )
				selection.remove(selection.find(origin))
	else:
		_state_machine.transition_to("Viewer")
	print("\n:::::::::\n", selection, "\n:::::::::\n")


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
				_state_machine.transition_to("Viewer")


static func merge_polygons(merger: Array):
	var main: Polygon2D = merger.pop_front()
	for sub in merger:
		main.polygon = Geometry.merge_polygons_2d(main.polygon, sub.polygon).max()
	return main.polygon


func _on_Unite_pressed() -> void:
	if len(selection) > 1:
		selection[0].polygon = merge_polygons(selection)
		# print("\n????????????????????\n",selection,"\n????????????????????\n")
		selection.pop_at(0)
		for poly in selection:
			# print("\n!!!!!!!!!!!!!!!!!\n",poly,"\n!!!!!!!!!!!!!!!!!\n")
			poly.queue_free()
			selection.pop_at(selection.find(poly))
		_state_machine.transition_to("Viewer")



func _on_Subtract_pressed() -> void:
	if len(selection) > 1:
		var main = selection[0]
		selection.pop_front()
		main.polygon = Geometry.clip_polygons_2d(main, merge_polygons(selection)) 
		for poly in selection:
			poly.queue_free()
		_state_machine.transition_to("Viewer")


func _on_Intersect_pressed() -> void:
	if len(selection) > 1:
		var new_rect: = Polygon2D.new()
		for polygon in selection:
			polygon.free()
		_state_machine.transition_to("Viewer")


func _on_Exclude_pressed() -> void:
	pass # Replace with function body.


func _on_Del_pressed() -> void:
	var layers: = get_node("../../UI/Sidebar/ScrollContainer/Column/Editor/Margin/Column/Layers/Tree")
	if not selection.empty():
		for polygon in selection:
			polygon.free()
			layers.update()
			selection.pop_at(selection.find(polygon))
	_state_machine.transition_to("Viewer")
