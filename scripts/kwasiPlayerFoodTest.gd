extends Node2D

@export var full : int

@export var indigest : int

@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func player_eat_food():
	if (player):
		if (player.canEat && !player.isFull):
			player.currentIndigest += indigest
			if (player.currentIndigest >= player.maxIndigest):
				player.currentIndigest = player.maxIndigest
				player.canEat = false
				player.indigest_cooldown_timer.start()
				print("You got indigestion. Wait until it goes down before eating")
			else:
				player.currentFull += full
				if (player.currentFull >= player.maxFull):
					player.currentFull = player.maxFull
					player.canEat = false;
					player.isFull = true;
					print("You are full")
		else:
			print("Player can't eat right now")
	else:
		print("Player Is Null")
