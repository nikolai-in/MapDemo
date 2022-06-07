extends Tree

onready var MapCanvas : Node2D = owner.get_node("MapCanvas/Navigation2D")

var selected: TreeItem
var origin_color: Color


func update() -> void:
	clear()
	var root: TreeItem = create_item(self)
	for element in MapCanvas.get_children():
		if is_instance_valid(element):
			var item: = create_item(root)
			item.set_text(0, element.name)
			item.set_editable(0, true)
			item.set_metadata(0, element)


func _on_Tree_item_edited() -> void:
	var edited: = get_edited()
	edited.get_metadata(0).name = edited.get_text(0)
