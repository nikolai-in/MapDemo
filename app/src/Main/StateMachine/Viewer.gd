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
	var sel: = get_node("../Selection")	
	for btn in buttons:
		btn.pressed = false
	for item in get_node("../../MapCanvas/Navigation2D").get_children(): # sel.selection:
		if is_instance_valid(item):
			item.self_modulate = Color( 1, 1, 1, 1 )
	sel.selection.clear()
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


onready var from_fld: = get_node("../../UI/Sidebar/ScrollContainer/Column/Search/Margin/Column/From")
onready var to_fld: = get_node("../../UI/Sidebar/ScrollContainer/Column/Search/Margin/Column/To")
onready var nav: = get_node("../../MapCanvas/Navigation2D") 
onready var line: = get_node("../../MapCanvas/Line2D") 


var from: = Vector2.ZERO
var to: = Vector2.ZERO

func _on_From_text_entered(new_text: String) -> void:
	var found: = false
	for room in nav.get_children():
		if room.get_meta("type") == "Room":
			if room.get_child(0).text == new_text:
				from = room.get_child(0).get_position()
				found = true
				# print("\n*****\n", from, room, "\n*****\n")
				break
	if not found:
		from_fld.clear()


func _on_To_text_entered(new_text: String) -> void:
	var found: = false
	for room in nav.get_children():
		if room.get_meta("type") == "Room":
			if room.get_child(0).text == new_text:
				to = room.get_child(0).get_position()
				found = true
				# print("\n*****\n", from, room, "\n*****\n")
				break
	if not found:
		to_fld.clear()


func _on_Button_pressed() -> void:
	if from != Vector2.ZERO || to != Vector2.ZERO:
		var path = nav.get_simple_path(from, to, true)
		print("\n*****\n", path, "\n*****\n")
		line.points = PoolVector2Array(path)
