extends Area2D
class_name Task

onready var sprite: AnimatedSprite = $"sprite"
onready var room = $"../room_common"

var doing: bool = false setget set_doing
var active: bool = false

const fixrate: float = 1.0

func _ready():
	$"instructions".play()
	$"instructions".frames.set_animation_loop($"instructions".animation, true)
	$"sprite".stop()
	$"sprite".frames.set_animation_loop($"sprite".animation, true)

func _process(delta):
	if active:
		if Input.is_action_just_pressed("interact_primary"):
			set_doing(true)
		if Input.is_action_just_released("interact_primary"):
			set_doing(false)
	if doing:
		if sprite.frame == 0:
			room.timer.start(min(room.maxtime, room.timer.time_left + fixrate))
			Sounds.play("hit1", position)

func set_doing(v: bool):
	if v != doing:
		doing = v
		if doing:
			sprite.play()
			if room.maxtime > 1 and room.timer.time_left < 1:
				room.timer.start(1)
		else:
			sprite.stop()
			
func _on_entered(body: KinematicBody2D):
	if not body: return
	if body.name == "player":
		print_debug("player enter", name)
		sprite.modulate = Color.white
		active = true

func _on_exited(body: KinematicBody2D):
	if not body: return
	if body.name == "player":
		print_debug("player exit", name)
		sprite.modulate = Color(1.0, 1.0, 1.0, 0.5)
		active = false
		set_doing(false)
