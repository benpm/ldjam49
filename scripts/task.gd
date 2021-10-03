extends Area2D
class_name Task

export(String) var hit_sound := "hit1"
export(bool) var loop_sound := false

onready var sprite: AnimatedSprite = $"sprite"
onready var room = $"../room_common"

var active: bool = false

func _ready():
	$"instructions".play()
	$"instructions".frames.set_animation_loop($"instructions".animation, true)
	$"sprite".stop()
	$"sprite".frames.set_animation_loop($"sprite".animation, true)

func fix_tick(multiplier: float = 1.0):
	room.timer.start(min(room.maxtime, room.timer.time_left + Global.player.fixrate * multiplier))
	if loop_sound:
		Sounds.unpause(hit_sound, position)
	else:
		Sounds.play(hit_sound, position)
			
func _on_entered(body: KinematicBody2D) -> bool:
	if not body: return false
	if body.name == "player":
		sprite.modulate = Color.white
		active = true
		return true
	return false

func _on_exited(body: KinematicBody2D) -> bool:
	if not body: return false
	if body.name == "player":
		sprite.modulate = Color(1.0, 1.0, 1.0, 0.5)
		active = false
		sprite.stop()
		sprite.frame = 0
		#TODO: Sound here
		return true
	return false
