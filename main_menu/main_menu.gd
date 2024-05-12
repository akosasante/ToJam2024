extends Control

var showIntructions: bool = false
var showCredits: bool = false

@onready var welcome_sound_effect = $WelcomeSoundEffect
@onready var leaving_sound_effect = $LeavingSoundEffect

func _ready():
	pass

func _on_start_button_pressed():
	if (welcome_sound_effect):
		welcome_sound_effect.play(4.0)
		await get_tree().create_timer(1.0).timeout
		
	var game_scene := load("res://scenes/game.tscn")
	MenuGlobals.reset_all()
	SceneTransition.change_scene_with_dissolve(game_scene)
	
func _on_exit_button_pressed():
	if (leaving_sound_effect):
		leaving_sound_effect.play()
		await get_tree().create_timer(2.0).timeout
		
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

