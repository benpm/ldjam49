extends Node

onready var cam: Camera2D = $"/root/scene/main_camera"
onready var game: Node2D = $"/root/scene/"
onready var player: Player = $"/root/scene/player"

var time_reduce_amnt := 0.25
var max_timer_len := 30.0
var room_spawn_interval := 30.0
var room_spawn_reduce := 0.1
var rtile_size := 32 * 8