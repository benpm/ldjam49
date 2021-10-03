tool
extends Node2D
class_name Room

export(Vector2) var room_size = Vector2.ONE setget set_room_size

onready var task_node: Task = find_node("task_*")
onready var timer: Timer = $vanish_timer
onready var hue: float = rand_range(0.1, 0.9)
onready var tilemap_fg: TileMap = $tilemap_fg
onready var progress: TextureProgress = $progress

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.h = hue

func _process(_delta):
	if Engine.editor_hint:
		modulate = Color.white
		return

	var t = timer.time_left
	modulate.h = hue
	modulate.v = clamp(0.2 + t / 30.0, 0.4, 1.0)
	modulate.s = clamp(t / 10.0, 0.0, 0.7)
	progress.value = t
	# if t < 5.0:
	# 	var tt = 0.5 - (t / 5.0)
	# 	tilemap_fg.position = Vector2(rand_range(tt, tt) * 32, rand_range(tt, tt) * 32)
	# else:
	# 	tilemap_fg.position = Vector2.ZERO

func set_room_size(val: Vector2):
	if !Engine.editor_hint:
		yield(self, "ready")
	if get_parent() and $"area/area_shape":
		room_size = val
		$"area/area_shape".shape.extents = room_size * 128
		$"area/area_shape".position = (room_size * 128) - Vector2(128, 128)
		print_debug($"area/area_shape".position)
	else:
		push_warning("room not ready")

func _on_vanish_timer_timeout():
	queue_free()
	# TODO: make explody sound
	# TODO: vanish animation