extends KinematicBody2D

export(float) var maxfall: float = 16.0
export(float) var movespeed: float = 8.0
export(float) var gravity: float = 0.35
export(float) var jumpvel: float = 6

var vel: Vector2 = Vector2(0, 0)
var pvel: Vector2
var jumps: int = 0
var sprite: AnimatedSprite
var maxy: float
var initpos: Vector2
var on_one_way: bool
var sounds: Sounds
var landed: bool
var stepped: bool

func _ready() -> void:
	sprite = get_child(1)
	sounds = get_node("/root/scene/sounds")
	assert(sounds != null)
	maxy = get_node("/root/scene/world_bottom").position.y
	initpos = position

func _process(_delta: float) -> void:
	# Control animation
	if abs(vel.y) < 0.1:
		if sprite.animation != "run":
			sprite.animation = "run"
		sprite.speed_scale = abs(vel.x / 3)
		if vel.x == 0:
			sprite.frame = 0
		if sprite.frame == 1 and not stepped:
			sounds.play("walk")
			stepped = true
		elif sprite.frame != 1:
			stepped = false
	elif vel.y > 0.1:
		sprite.animation = "fall"
	if abs(vel.x) > 0:
		sprite.flip_h = vel.x < 0
	
	# Fall through one-way platforms
	if Input.is_action_just_pressed("fall"):
		if !test_move(transform, Vector2(0, 48)):
			position.y += 2
		if vel.y != 0:
			vel.y = 6
	
	# World boundary
	if position.y > maxy:
		death()

func _physics_process(_delta: float) -> void:
	# Move left and right
	if Input.is_action_pressed("right"):
		vel.x = movespeed
	elif Input.is_action_pressed("left"):
		vel.x = -movespeed
	else:
		vel.x = 0
	
	# Set velocity to zero on ground
	if is_on_floor():
		if pvel.y > gravity:
			sounds.play("land")
		vel.y = 0
		jumps = 2
	else:
		vel.y += gravity
	
	# Jump
	if Input.is_action_just_pressed("jump") and jumps > 0:
		vel.y = -jumpvel
		jumps -= 1
		sprite.speed_scale = 1
		sprite.play("jump")
		sounds.play("jump")
	
	# Terminal velocity
	vel.y = min(vel.y, maxfall)
	
	# Collision
	pvel = vel
	vel = move_and_slide(vel * 60, Vector2(0, -1)) / 60
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if col.collider is TileMap:
			var t: TileMap = col.collider
			var p = t.world_to_map(col.position)
			var c = t.get_cell_autotile_coord(p.x, p.y)
			if t.tile_set.is_damage_tile(c):
				death()

func death():
	position = initpos
	sounds.play("die")
