extends Node2D
class_name Room

export(Vector2) var room_size = Vector2.ONE

onready var task_node: Task = find_node("task_*")
onready var timer: Timer = $vanish_timer
onready var hue: float = rand_range(0.1, 0.9)
onready var tilemap_fg: TileMap = $tilemap_fg
onready var bar: TextureProgress = $"progress/bar"
onready var bar_over: TextureProgress = $"progress/bar_over"

var maxtime: float
var room_loc: Vector2 = Vector2.ZERO

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
	print_debug("place room ", get_parent().name, room_loc, room_size, get_parent().position)

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

func set_room_extents():
	if get_parent() and $"area/area_shape":
		$"area/area_shape".shape.extents = room_size * Global.rtile_size
		$"area/area_shape".position = (room_size * Global.rtile_size) \
			- Vector2(Global.rtile_size, Global.rtile_size)
	else:
		push_warning("room not ready")

func _on_vanish_timer_timeout():
	print_debug("_on_vanish_timer_timeout()")
	Global.game.remove_room(get_parent())
	# TODO: make explody sound
	# TODO: vanish animation
