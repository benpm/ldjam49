extends Task
class_name HoldTask

export(Array) var keys: Array
export(float) var fix_rate: float = 0.50

var doing: bool = false setget set_doing

func _ready():
	$"instructions".play()
	$"instructions".frames.set_animation_loop($"instructions".animation, true)
	$"sprite".stop()
	$"sprite".frames.set_animation_loop($"sprite".animation, true)

func _process(delta):
	if active:
		var held: int = 0
		for key in keys:
			if Input.is_action_pressed(key):
				held += 1
			else:
				held -= 1
		set_doing(held == keys.size())
	if doing:
		if sprite.frame == 0:
			.fix_tick(fix_rate)

func set_doing(v: bool):
	if v != doing:
		doing = v
		if doing:
			sprite.play()
			if room.maxtime > 1 and room.timer.time_left < 1:
				room.timer.start(1)
		else:
			sprite.stop()
			if not loop_sound:
				Sounds.pause(hit_sound)

func _on_exited(body: KinematicBody2D):
	var exited = ._on_exited(body)
	if exited:
		set_doing(false)
