extends Polygon2D

onready var text: = $Label


func _ready() -> void:
	text.position = polygon[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
