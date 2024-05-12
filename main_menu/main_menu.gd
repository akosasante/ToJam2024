extends Control
var audioMuted = false

func _ready():
	pass

func _on_sound_button_pressed():
	audioMuted = !audioMuted
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, audioMuted)

func _on_start_button_pressed():
	var game_scene := load("res://scenes/game.tscn")
	MenuGlobals.reset_all()
	SceneTransition.change_scene_with_dissolve(game_scene)

func _on_exit_button_pressed():
	get_tree().quit()
