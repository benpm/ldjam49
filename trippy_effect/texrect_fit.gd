extends TextureRect

export(bool) var reposition = false
export(bool) var slide = false

onready var lastcampos: Vector2 = rect_position
onready var lastlastcampos: Vector2 = rect_position

func _process(_delta: float) -> void:
	var scvsize = $'..'.get_viewport().size
	var target_pos: Vector2
	if texture.get_size() != rect_size:
		rect_size = texture.get_size()
		if reposition:
			target_pos = -rect_size / 2
			pass
		else:
			target_pos = Vector2(0, 0)
		print_debug(name, rect_size)
	if slide:
		rect_position = lastlastcampos
		lastlastcampos = lastcampos
		lastcampos = $'../main_camera'.position - scvsize / 2
	else:
		rect_position = target_pos
