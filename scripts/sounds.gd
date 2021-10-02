extends Node

class_name Sounds

func play(sound: String) -> void:
	var sound_node: AudioStreamPlayer = get_node(sound)
	sound_node.stream.loop = false
	sound_node.stop()
	sound_node.play()

func unpause(sound: String) -> void:
	var sound_node: AudioStreamPlayer = get_node(sound)
	if not sound_node.playing:
		sound_node.play()

func pause(sound: String) -> void:
	var sound_node: AudioStreamPlayer = get_node(sound)
	sound_node.stop()