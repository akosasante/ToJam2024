extends Control

var showIntructions: bool = false
var showCredits: bool = false

func _ready():
	pass

func _on_start_button_pressed():
	var game_scene := load("res://scenes/game.tscn")
	MenuGlobals.reset_all()
	SceneTransition.change_scene_with_dissolve(game_scene)

func _on_exit_button_pressed():
	get_tree().quit()

func _on_instructions_button_pressed():
	showIntructions = !showIntructions
	$Instructions.visible = showIntructions

func _on_close_instructions_pressed():
	showIntructions = !showIntructions
	$Instructions.visible = showIntructions

func _on_credits_button_pressed():
	showCredits = !showCredits
	$Credits.visible = showCredits

func _on_close_credits_pressed():
	showCredits = !showCredits
	$Credits.visible = showCredits
