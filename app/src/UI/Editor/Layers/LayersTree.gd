extends Tree

onready var MapCanvas : Node2D = owner.get_node("MapCanvas")

var selected: TreeItem
var origin_color: Color


func update() -> void:
	clear()
	var root: TreeItem = create_item(self)
	for element in MapCanvas.get_children():
		if element == $_NULL:
			element.free()
			continue
		if is_instance_valid(element):
			var item: = create_item(root)
			item.set_text(0, element.name)
			item.set_metadata(0, element)
