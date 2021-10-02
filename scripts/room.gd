tool
extends Node2D


export(Vector2) var room_size = Vector2.ONE setget set_room_size

# Called when the node enters the scene tree for the first time.
func _ready():
	set_room_size(room_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_room_size(val: Vector2):
	if get_parent() and $"area/area_shape":
		print_tree_pretty()
		room_size = val
		$"area/area_shape".shape.extents = room_size * 128
	else:
		push_warning("room not ready")
		print_tree_pretty()
