extends TextureRect

export(bool) var reposition = false
export(bool) var slide = false

onready var lastcampos: Vector2 = rect_position
onready var lastlastcampos: Vector2 = rect_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target_pos: Vector2
	if texture.get_size() != rect_size:
		rect_size = texture.get_size()
		if reposition:
			target_pos = -rect_size / 2
		else:
			target_pos = Vector2(0, 0)
		print_debug(name, rect_size)
	if slide:
		rect_position = lastlastcampos
		lastlastcampos = lastcampos
		lastcampos = $'../main_camera'.position - rect_size / 2
	else:
		rect_position = target_pos
