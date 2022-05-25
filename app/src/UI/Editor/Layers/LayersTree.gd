extends Tree

onready var MapCanvas : Node2D = owner.get_node("MapCanvas")


func make_root(node: Node) -> TreeItem:
	var root: TreeItem = create_item()
	root.set_text(0, node.name)
	root.set_metadata(0, node)
	return root

func update() -> void:
	clear()
	var root = make_root(MapCanvas)
	for element in MapCanvas.get_children():
		var item: = create_item(root)
		item.set_text(0, element.name)
		item.set_metadata(0, element)


func _on_Tree_item_selected() -> void:
	var selected: = get_selected()
	var origin = selected.get_metadata(0)
	if origin is Polygon2D:
		origin.color = Color.red
