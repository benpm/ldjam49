extends Camera2D


var t := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	if not Global.player.dead:
		var target = Global.player.position
		var move = lerp(position, target, 0.1) - position
		position.x += round(move.x)
		position.y += round(move.y)
	else:
		position.x += cos(t / 10.0) * 4.0
		position.y -= 1.0
