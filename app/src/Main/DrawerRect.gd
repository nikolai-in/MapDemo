extends State

onready var MapCanvas : Node2D = owner.get_node("MapCanvas")

export var StateOptions : NodePath 
var Options: = preload("res://src/UI/debug/DebugPanel.tscn").instance()

var start_pos: = Vector2.ZERO
var end_pos: = Vector2.ZERO


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


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	Options.reference_path = self.get_path()
	Options.properties = PoolStringArray(["start_pos","end_pos"])
	get_node(StateOptions).add_child(Options)


func exit() -> void:
	get_node(StateOptions).remove_child(Options)
