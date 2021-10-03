extends Node2D
class_name Room

export(Vector2) var room_size = Vector2.ONE

onready var task_node: Task = find_node("task_*")
onready var timer: Timer = $vanish_timer
onready var hue: float = rand_range(0.1, 0.9)
onready var tilemap_fg: TileMap = $tilemap_fg
onready var tilemap_bg: TileMap = $tilemap_bg
onready var bar: TextureProgress = $"progress/bar"
onready var bar_over: TextureProgress = $"progress/bar_over"
onready var fx_anim: AnimationPlayer = $fx_anim

var maxtime: float
var room_loc: Vector2 = Vector2.ZERO
var prev_time: float

# Called when the node enters the scene tree for the first time.
func _ready():
	set_room_extents()
	modulate.h = hue
	bar.max_value = Global.max_timer_len
	bar.value = bar.max_value * rand_range(0.5, 1.0)
	maxtime = Global.max_timer_len
	bar_over.max_value = Global.max_timer_len
	bar_over.value = bar_over.max_value
	get_parent().position = room_loc * Global.rtile_size
	fx_anim.play("appear")

func _process(delta):
	if Engine.editor_hint:
		modulate = Color.white
		return

	var t = timer.time_left
	modulate.h = hue
	modulate.v = clamp(0.2 + t / Global.max_timer_len, 0.4, 1.0)
	modulate.s = clamp(t / 10.0, 0.0, 0.7)
	bar.value = t
	maxtime -= Global.time_reduce_amnt * delta
	bar_over.value = maxtime
	if t < 7.0:
		var tt = 1.0 - (t / 7.0)
		var amnt = pow(3.0 * (tt + 0.2), 1.5)
		tilemap_fg.material.set_shader_param("amount",  amnt)
		tilemap_bg.material.set_shader_param("amount",  amnt)
		tilemap_bg.position = Vector2(rand_range(-tt, tt) * 1.5, rand_range(-tt, tt) * 1.5)
		tilemap_bg.scale = Vector2(1 + rand_range(-tt, tt) * 0.2, 1 + rand_range(-tt, tt) * 0.2)
	elif prev_time <= 7.0:
		tilemap_fg.material.set_shader_param("amount",  0)
		tilemap_bg.material.set_shader_param("amount",  0)
		tilemap_bg.position = Vector2.ZERO
		tilemap_bg.scale = Vector2.ZERO
	prev_time = t

func set_room_extents():
	if get_parent() and $"area/area_shape":
		$"area/area_shape".shape.extents = room_size * Global.rtile_size
		$"area/area_shape".position = (room_size * Global.rtile_size) \
			- Vector2(Global.rtile_size, Global.rtile_size)
	else:
		push_warning("room not ready")

func _on_vanish_timer_timeout():
	Global.game.remove_room(get_parent())
	# TODO: make explody sound
	# TODO: vanish animation


func _on_fx_anim_animation_finished(anim_name):
	pass # Replace with function body.
