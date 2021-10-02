extends Camera2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = $'../player'.position
	var move = lerp(position, target, 0.1) - position
	position.x += round(move.x)
	position.y += round(move.y)
