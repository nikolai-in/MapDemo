extends Tree

onready var MapCanvas : Node2D = owner.get_node("MapCanvas")

var selected: TreeItem
var origin_color: Color

var names = []
var root: TreeItem

func _ready() -> void:
	root = create_item()
	root.set_text(0, MapCanvas.name)
	root.set_metadata(0, MapCanvas)
	

func update() -> void:
	for element in MapCanvas.get_children():
		if not element.name in names:
			names.append(element.name)
			var item: = create_item(root)
			item.set_text(0, element.name)
			item.set_metadata(0, element)
