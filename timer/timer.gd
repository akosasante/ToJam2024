extends Node2D

var initialTime = 120
var currentTime = initialTime

func _ready():
	updateTimerDisplay()

#Timer wait time is 1s
func _on_timer_timeout():
	if currentTime > 0:
		currentTime -= 1
		updateTimerDisplay()
	else:
		$TimerDisplay.text = "Game Over"
	
func updateTimerDisplay():
	var minutes = currentTime / 60
	var seconds = currentTime % 60
	$TimerDisplay.text = "%01d:%02d" % [minutes, seconds]
	$TimeBar.value = currentTime
	
func _on_play_button_pressed():
	$Timer.start()

func _on_pause_button_pressed():
	$Timer.stop()
	
func _on_reset_button_pressed():
	$Timer.stop()
	currentTime = initialTime
	updateTimerDisplay()

func _on_time_bar_value_changed(value):
	if value < 30:
		$TimeBar.tint_progress = Color(1, 0, 0)
	else:
		$TimeBar.tint_progress = Color(0, 1, 0)
