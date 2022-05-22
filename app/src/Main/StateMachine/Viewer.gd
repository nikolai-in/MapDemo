extends State

export var tools_path : NodePath

onready var AddRect : Button = get_node(str(tools_path) + "/AddRect")
onready var AddLine : Button = get_node(str(tools_path) + "/AddLine")
onready var AddPoint : Button = get_node(str(tools_path) + "/AddPoint")


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


func _on_AddRect_toggled(button_pressed: bool) -> void:
	if button_pressed:
		_state_machine.transition_to("Editor/DrawerRect")
	elif !AddLine.pressed && !AddPoint.pressed:
		_state_machine.transition_to("Viewer")


func _on_AddLine_toggled(button_pressed: bool) -> void:
	if button_pressed:
		_state_machine.transition_to("Editor/DrawerLine")
	elif !AddRect.pressed && !AddPoint.pressed:
		_state_machine.transition_to("Viewer")


func _on_AddPoint_toggled(button_pressed: bool) -> void:
	if button_pressed:
		_state_machine.transition_to("Editor/DrawerPoint")
	elif !AddLine.pressed && !AddRect.pressed:
		_state_machine.transition_to("Viewer")
