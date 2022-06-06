extends ItemList


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var color_picker: = get_node("../ColorPickerButton")

var colors = []
var index_old: = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_item("Коридор")
	add_item("Аудитория")
	colors.append(Color("2c2a32"))
	colors.append(Color("b2df2727"))
	select(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_RoomTypes_item_selected(index: int) -> void:
	colors[index_old] = color_picker.color
	color_picker.color = colors[index]
	index_old = index
