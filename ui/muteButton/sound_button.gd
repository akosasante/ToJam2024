extends Control

func _ready():
	$SoundButton.button_pressed = !Settings.audioMuted

func _on_sound_button_pressed():
	Settings.toggleMute()
