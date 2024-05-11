extends Node2D



func _ready():
	pass
	

func startTimer():
	$Timer.start()
	$label.text = "Started"
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
