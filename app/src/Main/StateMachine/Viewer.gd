extends State

export var tools_path : NodePath

onready var AddRect : Button = get_node(str(tools_path) + "/AddRect")
onready var AddLine : Button = get_node(str(tools_path) + "/AddLine")
onready var AddPoint : Button = get_node(str(tools_path) + "/AddPoint")
onready var Del : Button = get_node(str(tools_path) + "/Del")

onready var buttons: = [AddRect, AddLine, AddPoint, Del]

onready var PanningCamera: PanningCamera2D = owner.get_node("PanningCamera2D")


func unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == BUTTON_MASK_LEFT:
			PanningCamera.position -= event.relative * PanningCamera.zoom


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	for btn in buttons:
		btn.pressed = false
	get_node("../../UI/Sidebar/ScrollContainer/Column/Editor/Margin/Column/Layers/Tree").update()


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
