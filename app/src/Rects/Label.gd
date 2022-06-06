extends Label

onready var polygon : PoolVector2Array = get_parent().polygon 


func _ready() -> void:
	center()


func _on_Polygon2D_renamed() -> void:
	center()
	text = owner.name

func center():
	rect_position = (polygon[0]+polygon[2])/2 - rect_size/2	
