extends Button

@onready var button = $"."

var end_game_scene := preload("res://scenes/end_screen.tscn")

func _ready():
	pass


func _on_pressed():
	SceneTransition.change_scene_with_dissolve(end_game_scene)
