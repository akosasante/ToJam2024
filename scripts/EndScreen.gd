extends Node2D

var game_scene := preload("res://scenes/game.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_again_pressed():
	SceneTransition.change_scene_with_dissolve(game_scene)


func _on_exit_pressed():
	print_debug("QUITTING")
	# TODO Maybe we play a sound here?
	get_tree().quit()
