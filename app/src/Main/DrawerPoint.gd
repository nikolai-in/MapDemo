extends State

onready var MapCanvas : Node2D = owner.get_node("MapCanvas")

export var StateOptions : NodePath = "../../../UI/Sidebar/ScrollContainer/Column/StateOptions"
export var OptionsScene : PackedScene = preload("res://src/UI/debug/DebugPanel.tscn")
var Options : PanelContainer = OptionsScene.instance()

var point: = Vector2.ZERO


func unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				point = MapCanvas.get_global_mouse_position()
				print_debug("Point: ", point)
				_state_machine.transition_to("Viewer")


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	Options.reference_path = self.get_path()
	Options.properties = PoolStringArray(["point"])
	get_node(StateOptions).add_child(Options)


func exit() -> void:
	get_node(StateOptions).remove_child(Options)
	point = Vector2.ZERO
