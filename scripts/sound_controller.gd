extends Node

onready var soundFX := Node2D.new()
onready var cam: Camera2D = $"/root/scene/main_camera"
onready var viewsize: Vector2 = $'..'.get_viewport().size

var sounds: Dictionary

func _ready() -> void:

	# Load all the audio
	var audioDir = Directory.new()
	audioDir.open("res://sounds/")
	audioDir.list_dir_begin(true, true)
	var fname = audioDir.get_next()
	while fname:
		if fname.get_extension() == "ogg":
			var streamName: String = fname.get_basename()
			var stream: AudioStreamOGGVorbis = load("res://sounds/" + fname)
			stream.loop = false
			var streamPlayer = AudioStreamPlayer2D.new()
			streamPlayer.name = streamName
			streamPlayer.stream = stream
			streamPlayer.autoplay = false
			streamPlayer.bus = "sound fx"
			streamPlayer.attenuation = 2.0
			sounds[streamName] = streamPlayer
			soundFX.add_child(streamPlayer)
		fname = audioDir.get_next()

	add_child(soundFX)

# Call to play a sound
func play(name: String, pos = null):
	sounds[name].stop()
	if pos != null:
		sounds[name].position = (pos - cam.position) + (viewsize / 2)
	sounds[name].play()

# Set sounds to playing or not
func playing(name: String, playing: bool, pos = null):
	if sounds[name].playing != playing:
		sounds[name].playing = playing
	if pos != null:
		sounds[name].position = (pos - cam.position) + (viewsize / 2)

func unpause(name: String, pos = null) -> void:
	playing(name, true, pos)

func pause(name: String, pos = null) -> void:
	playing(name, false, pos)