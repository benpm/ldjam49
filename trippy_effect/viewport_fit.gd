extends Viewport


onready var ires_obj: IntegerResolutionHandler = $"/root/IntegerResolutionHandler"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var scvsize = $'..'.get_viewport().size / ires_obj.scale
	if int(size.x) != int(scvsize.x) or int(size.y) != int(scvsize.y):
		size = scvsize
		print_debug(name, size)
	pass
