extends Node

onready var soundFX := Node2D.new()
onready var viewsize: Vector2 = $'..'.get_viewport().size

var sounds: Dictionary

const sound_appear = preload("res://sounds/appear.ogg")
const sound_collapse = preload("res://sounds/collapse.ogg")
const sound_die = preload("res://sounds/die.ogg")
const sound_hammer = preload("res://sounds/hammer.ogg")
const sound_hammering = preload("res://sounds/hammering.ogg")
const sound_hit1 = preload("res://sounds/hit1.ogg")
const sound_hit2 = preload("res://sounds/hit2.ogg")
const sound_jump1 = preload("res://sounds/jump1.ogg")
const sound_jump2 = preload("res://sounds/jump2.ogg")
const sound_rumble = preload("res://sounds/rumble.ogg")
const sound_run = preload("res://sounds/run.ogg")
const sound_spin = preload("res://sounds/spin.ogg")
const sound_zap = preload("res://sounds/zap.ogg")

func _ready() -> void:
	var sound_appear_strm = AudioStreamPlayer2D.new()
	sound_appear.loop = false
	sound_appear_strm.stream = sound_appear
	sound_appear_strm.name = "appear"
	sound_appear_strm.autoplay = false
	sound_appear_strm.bus = "sound fx"
	sound_appear_strm.attenuation = 4.0
	sounds["appear"] = sound_appear_strm
	soundFX.add_child(sound_appear_strm)

	var sound_collapse_strm = AudioStreamPlayer2D.new()
	sound_collapse.loop = false
	sound_collapse_strm.stream = sound_collapse
	sound_collapse_strm.name = "collapse"
	sound_collapse_strm.autoplay = false
	sound_collapse_strm.bus = "sound fx"
	sound_collapse_strm.attenuation = 4.0
	sounds["collapse"] = sound_collapse_strm
	soundFX.add_child(sound_collapse_strm)

	var sound_die_strm = AudioStreamPlayer2D.new()
	sound_die.loop = false
	sound_die_strm.stream = sound_die
	sound_die_strm.name = "die"
	sound_die_strm.autoplay = false
	sound_die_strm.bus = "sound fx"
	sound_die_strm.attenuation = 4.0
	sounds["die"] = sound_die_strm
	soundFX.add_child(sound_die_strm)

	var sound_hammer_strm = AudioStreamPlayer2D.new()
	sound_hammer.loop = false
	sound_hammer_strm.stream = sound_hammer
	sound_hammer_strm.name = "hammer"
	sound_hammer_strm.autoplay = false
	sound_hammer_strm.bus = "sound fx"
	sound_hammer_strm.attenuation = 4.0
	sounds["hammer"] = sound_hammer_strm
	soundFX.add_child(sound_hammer_strm)

	var sound_hammering_strm = AudioStreamPlayer2D.new()
	sound_hammering.loop = false
	sound_hammering_strm.stream = sound_hammering
	sound_hammering_strm.name = "hammering"
	sound_hammering_strm.autoplay = false
	sound_hammering_strm.bus = "sound fx"
	sound_hammering_strm.attenuation = 4.0
	sounds["hammering"] = sound_hammering_strm
	soundFX.add_child(sound_hammering_strm)

	var sound_hit1_strm = AudioStreamPlayer2D.new()
	sound_hit1.loop = false
	sound_hit1_strm.stream = sound_hit1
	sound_hit1_strm.name = "hit1"
	sound_hit1_strm.autoplay = false
	sound_hit1_strm.bus = "sound fx"
	sound_hit1_strm.attenuation = 4.0
	sounds["hit1"] = sound_hit1_strm
	soundFX.add_child(sound_hit1_strm)

	var sound_hit2_strm = AudioStreamPlayer2D.new()
	sound_hit2.loop = false
	sound_hit2_strm.stream = sound_hit2
	sound_hit2_strm.name = "hit2"
	sound_hit2_strm.autoplay = false
	sound_hit2_strm.bus = "sound fx"
	sound_hit2_strm.attenuation = 4.0
	sounds["hit2"] = sound_hit2_strm
	soundFX.add_child(sound_hit2_strm)

	var sound_jump1_strm = AudioStreamPlayer2D.new()
	sound_jump1.loop = false
	sound_jump1_strm.stream = sound_jump1
	sound_jump1_strm.name = "jump1"
	sound_jump1_strm.autoplay = false
	sound_jump1_strm.bus = "sound fx"
	sound_jump1_strm.attenuation = 4.0
	sounds["jump1"] = sound_jump1_strm
	soundFX.add_child(sound_jump1_strm)

	var sound_jump2_strm = AudioStreamPlayer2D.new()
	sound_jump2.loop = false
	sound_jump2_strm.stream = sound_jump2
	sound_jump2_strm.name = "jump2"
	sound_jump2_strm.autoplay = false
	sound_jump2_strm.bus = "sound fx"
	sound_jump2_strm.attenuation = 4.0
	sounds["jump2"] = sound_jump2_strm
	soundFX.add_child(sound_jump2_strm)

	var sound_rumble_strm = AudioStreamPlayer2D.new()
	sound_rumble.loop = false
	sound_rumble_strm.stream = sound_rumble
	sound_rumble_strm.name = "rumble"
	sound_rumble_strm.autoplay = false
	sound_rumble_strm.bus = "sound fx"
	sound_rumble_strm.attenuation = 4.0
	sounds["rumble"] = sound_rumble_strm
	soundFX.add_child(sound_rumble_strm)

	var sound_run_strm = AudioStreamPlayer2D.new()
	sound_run.loop = false
	sound_run_strm.stream = sound_run
	sound_run_strm.name = "run"
	sound_run_strm.autoplay = false
	sound_run_strm.bus = "sound fx"
	sound_run_strm.attenuation = 4.0
	sounds["run"] = sound_run_strm
	soundFX.add_child(sound_run_strm)

	var sound_spin_strm = AudioStreamPlayer2D.new()
	sound_spin.loop = false
	sound_spin_strm.stream = sound_spin
	sound_spin_strm.name = "spin"
	sound_spin_strm.autoplay = false
	sound_spin_strm.bus = "sound fx"
	sound_spin_strm.attenuation = 4.0
	sounds["spin"] = sound_spin_strm
	soundFX.add_child(sound_spin_strm)

	var sound_zap_strm = AudioStreamPlayer2D.new()
	sound_zap.loop = false
	sound_zap_strm.stream = sound_zap
	sound_zap_strm.name = "zap"
	sound_zap_strm.autoplay = false
	sound_zap_strm.bus = "sound fx"
	sound_zap_strm.attenuation = 4.0
	sounds["zap"] = sound_zap_strm
	soundFX.add_child(sound_zap_strm)
	add_child(soundFX)

# Call to play a sound
func play(name: String, pos = null):
	assert(sounds.has(name))
	sounds[name].stop()
	if pos != null:
		sounds[name].position = Global.cam.position
	sounds[name].play()

# Set sounds to playing or not
func playing(name: String, playing: bool, pos = null):
	assert(sounds.has(name))
	if sounds[name].playing != playing:
		sounds[name].playing = playing
	if pos != null:
		sounds[name].position = Global.cam.position

func unpause(name: String, pos = null) -> void:
	playing(name, true, pos)

func pause(name: String, pos = null) -> void:
	playing(name, false, pos)
