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


# Called when the node enters the scene tree for the first time.
func _ready():
	init_effect()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Called on room creation
func _on_create_room_timer_timeout():
	pass