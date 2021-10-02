extends Area2D
class_name Task

onready var sprite: AnimatedSprite = $"sprite"
onready var room = find_parent("room")

var doing: bool = false setget set_doing
var active: bool = false

const fixrate: float = 5.0

func _process(delta):
	if active:
		if Input.is_action_just_pressed("interact_primary"):
			set_doing(true)
		if Input.is_action_just_released("interact_primary"):
			set_doing(false)
	if doing:
		room.timer.start(min(30.0, room.timer.time_left + fixrate * delta))

func set_doing(v: bool):
	if v != doing:
		doing = v
		if doing:
			sprite.play()
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
