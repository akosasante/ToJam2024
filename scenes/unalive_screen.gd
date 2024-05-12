extends Node2D

func _ready():
	pass # Replace with function body.
	
func _on_play_again_pressed():
	# Warn: gotta keep this as load, rather than preload which would be a bit more perfomrant because it seems to be messing with Godot's caching
	# https://github.com/godotengine/godot/issues/80981
	var game_scene := load("res://scenes/game.tscn")
	SceneTransition.change_scene_with_dissolve(game_scene)

func _on_exit_pressed():
	print_debug("QUITTING")
	# TODO Maybe we play a sound here?
	get_tree().quit()
