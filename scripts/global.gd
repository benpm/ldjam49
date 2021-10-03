extends Node

onready var cam: Camera2D = find_node("main_camera")
onready var game: Node2D = find_node("scene")

var time_reduce_amnt := 0.25
var max_timer_len := 30.0
var room_spawn_interval := 30.0
var room_spawn_reduce := 0.1