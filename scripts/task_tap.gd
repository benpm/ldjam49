extends Task
class_name TapTask

export(Array) var keys: Array

var keyidx: int = 0

func _ready():
	$"instructions".play()
	$"instructions".frames.set_animation_loop($"instructions".animation, true)
	$"sprite".stop()
	$"sprite".frames.set_animation_loop($"sprite".animation, true)

func _process(delta):
	if active:
		if Input.is_action_just_pressed(keys[keyidx]):
			.fix_tick(delta * 3.0)
			keyidx = (keyidx + 1) % keys.size()
			
func _on_entered(body: KinematicBody2D):
	var entered = ._on_entered(body)
	if entered:
		keyidx = 0


func _on_exited(body: KinematicBody2D):
	var exited = ._on_exited(body)
	if exited:
		keyidx = 0

