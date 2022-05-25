extends State

onready var tree: = get_node("../../UI/Sidebar/ScrollContainer/Column/Editor/Margin/Column/Layers/Tree")

var selection = []


func _on_Tree_multi_selected(item: TreeItem, column: int, selected: bool) -> void:
	var origin = item.get_metadata(column)
	if origin is Polygon2D:
		if selected:
			origin.self_modulate = Color( 2, 2, 2, 0.99 )
			selection.append(origin)
		else:
			origin.self_modulate = Color( 1, 1, 1, 1 )
			selection.remove(selection.find(origin))
	print(selection)
