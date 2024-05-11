extends Control

var audioMuted = false

func _ready():
	pass
	
func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_sound_button_pressed():
	audioMuted = !audioMuted
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, audioMuted)
