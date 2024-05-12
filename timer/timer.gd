extends Control

var initialTime = 120
var currentTime = initialTime
 
@onready var timerDisplay: Label = $CenterContainer/TimerDisplay
@onready var timeBar: TextureProgressBar = $CenterContainer/TimeBar

func _ready():
	$Timer.start()
	updateTimerDisplay()

#Timer wait time is 1s
func _on_timer_timeout():
	if currentTime > 0:
		currentTime -= 1
		updateTimerDisplay()
	else:
		# Warn: gotta keep this as load, rather than preload which would be a bit more perfomrant because it seems to be messing with Godot's caching
		# https://github.com/godotengine/godot/issues/80981
		var end_game_scene := load("res://scenes/end_screen.tscn")
		SceneTransition.change_scene_with_dissolve(end_game_scene)
	
func updateTimerDisplay():
	var minutes = currentTime / 60
	var seconds = currentTime % 60
	timerDisplay.text = "%01d:%02d" % [minutes, seconds]
	timeBar.value = currentTime

func _on_time_bar_value_changed(value):
	if value < 30:
		timeBar.tint_progress = Color(1, 0, 0) #red
	else:
		timeBar.tint_progress = Color(0, 1, 0) #green
