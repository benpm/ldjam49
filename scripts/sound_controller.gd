extends Node

onready var soundFX := Node2D.new()
onready var viewsize: Vector2 = $'..'.get_viewport().size

var sounds: Dictionary

func _ready() -> void:

	# Load all the audio
	var audio_dir = Directory.new()
	audio_dir.open("res://sounds/")
	audio_dir.list_dir_begin(true, true)
	var fname = audio_dir.get_next()
	while fname:
		if fname.get_extension() == "ogg":
			var bname: String = fname.get_basename()
			var stream: AudioStreamOGGVorbis = load("res://sounds/" + fname)
			stream.loop = false
			var player = AudioStreamPlayer2D.new()
			player.name = bname
			player.stream = stream
			player.autoplay = false
			player.bus = "sound fx"
			player.attenuation = 2.0
			sounds[bname] = player
			print_debug(bname)
			soundFX.add_child(player)
		fname = audio_dir.get_next()

	add_child(soundFX)

# Call to play a sound
func play(name: String, pos = null):
	assert(sounds.has(name))
	sounds[name].stop()
	if pos != null:
		sounds[name].position = (pos - Global.cam.position) + (viewsize / 2)
	sounds[name].play()

# Set sounds to playing or not
func playing(name: String, playing: bool, pos = null):
	assert(sounds.has(name))
	if sounds[name].playing != playing:
		sounds[name].playing = playing
	if pos != null:
		sounds[name].position = (pos - Global.cam.position) + (viewsize / 2)

func unpause(name: String, pos = null) -> void:
	playing(name, true, pos)

func pause(name: String, pos = null) -> void:
	playing(name, false, pos)
