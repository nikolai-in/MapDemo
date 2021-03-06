extends State

onready var MapCanvas : Node2D = owner.get_node("MapCanvas")

export var StateOptions : NodePath = "../../../UI/Sidebar/ScrollContainer/Column/StateOptions"
export var OptionsScene : PackedScene = preload("res://src/UI/debug/DebugPanel.tscn")
var Options : PanelContainer = OptionsScene.instance()

var start_pos: = Vector2.ZERO
var end_pos: = Vector2.ZERO

onready var color_picker: ColorPickerButton = get_node("../../../UI/Sidebar/ScrollContainer/Column/Editor/Margin/Column/ColorPickerButton")


func unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				start_pos = MapCanvas.get_global_mouse_position()
				print_debug("Start: ", start_pos)
		if !event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				end_pos = MapCanvas.get_global_mouse_position()
				print_debug("End: ", end_pos)
				MapCanvas.add_child(add_line(start_pos, end_pos, color_picker.color))
				_state_machine.transition_to("Viewer")
	if event is InputEventMouseMotion:
		if event.button_mask == BUTTON_MASK_LEFT:
			end_pos = MapCanvas.get_global_mouse_position()


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	Options.reference_path = self.get_path()
	Options.properties = PoolStringArray(["start_pos","end_pos"])
	get_node(StateOptions).add_child(Options)


func exit() -> void:
	get_node(StateOptions).remove_child(Options)
	start_pos = Vector2.ZERO
	end_pos = Vector2.ZERO

# Make into PoolVector2Array of points
func add_line(start: Vector2, end: Vector2, color: Color = Color.black) -> Polygon2D:
	var line: = Polygon2D.new()
	line.set_meta("type", "Line")
	line.color = color
	line.polygon = Geometry.offset_polyline_2d(PoolVector2Array([start, end]), 10)[0]
	print_debug(line.polygon, Geometry.offset_polyline_2d(PoolVector2Array([start, end]), 20))
	return line
