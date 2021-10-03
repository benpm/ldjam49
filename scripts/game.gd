extends Node2D

# Pre-load resources
var viewport_script: Script = preload("res://trippy_effect/viewport_fit.gd")
var texrect_script: Script = preload("res://trippy_effect/texrect_fit.gd")
var effect_material: Material = preload("res://trippy_effect/trippy_material.tres")

# Pass to shader
export(float) var shader_dissipate = 1.0

func init_effect() -> void:
	assert($main_camera, "must have a Camera2D node called 'main_camera'")
	var camera: Camera2D = $main_camera
	# Initial viewport size
	var isize: Vector2 = get_viewport().size
	
	# Add the scene viewport to hold everything in the scene
	var scene_viewport: Viewport = Viewport.new()
	scene_viewport.size = isize
	scene_viewport.transparent_bg = false
	scene_viewport.set_script(viewport_script)
	scene_viewport.name = "scene_viewport"
	add_child(scene_viewport)
	Global.scene = scene_viewport
	
	# Re-parent children to scene viewport
	for child in get_children():
		if child != scene_viewport:
			self.remove_child(child)
			scene_viewport.add_child(child)
	
	# Screen viewport
	var screen_viewport: Viewport = Viewport.new()
	screen_viewport.size = scene_viewport.size
	screen_viewport.transparent_bg = false
	screen_viewport.set_script(viewport_script)
	screen_viewport.name = "screen_viewport"
	self.add_child(screen_viewport)
	var screen_tex: TextureRect = TextureRect.new()
	screen_tex.texture = scene_viewport.get_texture()
	screen_tex.set_script(texrect_script)
	screen_tex.name = "screen_tex"
	screen_viewport.add_child(screen_tex)
	
	# Display tex
	var display_tex: TextureRect = TextureRect.new()
	display_tex.texture = screen_viewport.get_texture()
	display_tex.set_script(texrect_script)
	display_tex.name = "display_tex"
	add_child(display_tex)
	
	# Add effect to camera
	var effect: TextureRect = TextureRect.new()
	effect.texture = screen_viewport.get_texture()
	effect.set_script(texrect_script)
	effect.reposition = true
	effect.slide = true
	effect.rect_size = isize
	effect.rect_position = camera.position-isize / 2
	effect.material = effect_material
	effect.material.set_shader_param("dissipate", shader_dissipate)
	effect.name = "effect"
	scene_viewport.add_child(effect)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rooms: Array
var placed_rooms: Dictionary
var game_time: float = 0

onready var explode_particles: Particles2D = $"explode"
onready var score_label: RichTextLabel = $"main_camera/UI_layer/score_label"
onready var death_msgs: Control = $"main_camera/UI_layer/death_msgs"

# Called when the node enters the scene tree for the first time.
func _ready():
	death_msgs.hide()
	var rooms_dir = Directory.new()
	rooms_dir.open("res://objects/rooms")
	rooms_dir.list_dir_begin(true, true)
	var fname = rooms_dir.get_next()
	while fname:
		if fname.get_extension() == "tscn":
			var room_packed: PackedScene = load("res://objects/rooms/" + fname)
			rooms.append(room_packed)
		fname = rooms_dir.get_next()
	$create_room_timer.start(Global.room_spawn_interval)
	print_debug(rooms)
	
	# Create init room
	randomize()
	var room_node = load("res://objects/rooms/room_start.tscn").instance()
	var room = room_node.get_node("room_common")
	room.room_size = Vector2.ONE
	room.room_loc = Vector2.ZERO
	place_room(room_node)
	_on_create_room_timer_timeout()
	_on_create_room_timer_timeout()

	init_effect()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Global.player.dead:
		game_time += delta
		score_label.text = "%4d" % game_time

# Called on room creation
func _on_create_room_timer_timeout():
	if Global.player.dead:
		return
	var room_packed: PackedScene = rooms[randi() % rooms.size()]
	var room_node = room_packed.instance()
	var room = room_node.get_node("room_common")
	# Search for location to place new room
	var placed = false
	var locs = placed_rooms.keys()
	if locs.size() == 0:
		return
	var candirs = [
		Vector2(1, -1),
		Vector2(1, 0),
		Vector2(1, 1),
		Vector2(-1, -1),
		Vector2(-1, 0),
		Vector2(-1, 1),
		Vector2(0, -1),
		Vector2(0, 1)
	]
	while not placed:
		var sl: Vector2 = locs[randi() % locs.size()]
		candirs.shuffle()
		for dir in candirs:
			var cl = sl + dir
			if cl.y * Global.rtile_size > 400:
				continue
			var rs = room.room_size
			var placeable = true
			for rx in range(cl.x, cl.x + rs.x):
				for ry in range(cl.y, cl.y + rs.y):
					var rl = Vector2(rx, ry).floor()
					if placed_rooms.has(rl):
						placeable = false
						break
				if not placeable: break
			if placeable:
				room.room_loc = cl
				place_room(room_node)
				placed = true
				break

func place_room(room_node: Node2D):
	var room: Room = room_node.get_node("room_common")
	var loc = room.room_loc
	for rx in range(loc.x, loc.x + room.room_size.x):
		for ry in range(loc.y, loc.y + room.room_size.y):
			var rl = Vector2(rx, ry).floor()
			assert(!placed_rooms.has(rl))
			placed_rooms[rl] = room_node
	Global.scene.add_child(room_node)
	Sounds.play("appear", room_node.position)

func remove_room(room_node: Node2D):
	var room: Room = room_node.get_node("room_common")
	var loc = room.room_loc
	for rx in range(loc.x, loc.x + room.room_size.x):
		for ry in range(loc.y, loc.y + room.room_size.y):
			var erased = placed_rooms.erase(Vector2(rx, ry).floor())
			assert(erased)
	room_node.queue_free()
	explode_particles.restart()
	explode_particles.position = room_node.position
	explode_particles.emitting = true
	explode_particles.one_shot = true

func _on_room_collapse(room_node: Node2D):
	remove_room(room_node)

func player_died():
	death_msgs.show()
	death_msgs.get_node("final_score").text = "%d" % game_time

func _restart_game():
	print_debug("RESTART GAME")
	for r in placed_rooms:
		r.queue_free()
	placed_rooms.clear()
	game_time = 0
	Global.player.position = Vector2.ZERO
	Global.player.vel = Vector2.ZERO
	Global.player.dead = false

	# Create init room
	randomize()
	var room_node = load("res://objects/rooms/room_start.tscn").instance()
	var room = room_node.get_node("room_common")
	room.room_size = Vector2.ONE
	room.room_loc = Vector2.ZERO
	place_room(room_node)
	_on_create_room_timer_timeout()
	_on_create_room_timer_timeout()
