extends Area2D
class_name Task

onready var sprite: AnimatedSprite = $"sprite"

var doing: bool = false setget set_doing
var active: bool = false

func _process(_delta):
	if active:
		if Input.is_action_just_pressed("interact_primary"):
			set_doing(true)
		if Input.is_action_just_released("interact_primary"):
			set_doing(false)

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
