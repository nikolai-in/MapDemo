extends Button


func _ready() -> void:
	pass


func _on_tool_toggled(button_pressed: bool) -> void:
	if button_pressed:
		pressed = false
