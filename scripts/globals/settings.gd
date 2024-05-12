extends Node

var audioMuted : bool = false

func _ready():
	pass
	
func toggleMute():
	audioMuted = !audioMuted
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, audioMuted)
	
