extends Task
class_name TapTask

export(Array) var keys: Array
export(float) var fix_rate: float = 1.2

var keyidx: int = 0
var cur_fix_rate: float = fix_rate

func _ready():
	$"instructions".play()
	$"instructions".frames.set_animation_loop($"instructions".animation, true)
	$"sprite".stop()
	$"sprite".frames.set_animation_loop($"sprite".animation, false)

func _process(delta):
	if active:
		if Input.is_action_just_pressed(keys[keyidx]):
			.fix_tick(cur_fix_rate)
			cur_fix_rate *= 1.07
			keyidx = (keyidx + 1) % keys.size()
			$sprite.frame = 0
			$sprite.play()
		cur_fix_rate = lerp(cur_fix_rate, fix_rate, 0.1)
	else:
		cur_fix_rate = lerp(cur_fix_rate, fix_rate, 0.25)
			
func _on_entered(body: KinematicBody2D):
	var entered = ._on_entered(body)
	if entered:
		keyidx = 0


func _on_exited(body: KinematicBody2D):
	var exited = ._on_exited(body)
	if exited:
		keyidx = 0

