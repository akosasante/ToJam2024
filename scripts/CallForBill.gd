extends Node

@onready var button = $"."

func _ready():
	pass

func _on_pressed():
	# Warn: gotta keep this as load, rather than preload which would be a bit more perfomrant because it seems to be messing with Godot's caching
	# https://github.com/godotengine/godot/issues/80981
	var end_game_scene := load("res://scenes/end_screen.tscn")
	SceneTransition.change_scene_with_dissolve(end_game_scene)
