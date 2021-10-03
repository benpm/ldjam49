extends Viewport



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	return
	var scvsize = $'..'.get_viewport().size
	if int(size.x) != int(scvsize.x) or int(size.y) != int(scvsize.y):
		size = scvsize
