extends Node2D

const maxFull : int = 100
var currentFull : int = 0

@onready var isFull : bool = false

const maxIndigest : int = 100
var currentIndigest : int = 0

@export var indigest_reduction_amount : int = 5
@export var indigest_cooldown_wait_time : int = 10
@onready var indigest_cooldown_timer = $IndigestionCooldownTimer

@onready var canEat : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	indigest_cooldown_timer.wait_time = indigest_cooldown_wait_time
	
	print ("Max Fullness: %s" % maxFull)
	print ("Current Fullness: %s" % currentFull)
	
	print ("Max Indigestion: %s" % maxIndigest)
	print ("Current Indigestion: %s" % currentIndigest)
	pass # Replace with function body.


var timeVar = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!canEat && indigest_cooldown_timer.time_left > 0):
		timeVar += delta
		if (timeVar >= 1):
			print ("Time Left Until Indigestion Goes Down: %s" % time_left_until_eat())
			timeVar = 0
	pass
	
func eat_food(food):
	if (food):
		if (canEat && !isFull):
			currentFull += food.full
			currentIndigest += food.indigest
			print ("Current Fullness: %s" % currentFull)
			print ("Current Indigestion: %s" % currentIndigest)
			
			if (currentFull >= maxFull):
				currentFull = maxFull
				canEat = false;
				isFull = true;
				print("Player Is Now FULL!!!!!!!!!!!!!!!!!!!!!!!!")
			elif (currentIndigest >= maxIndigest):
				currentIndigest = maxIndigest
				canEat = false
				indigest_cooldown_timer.start()
				print("You got indigestion. Wait until it goes down before eating")
		else:
			print ("Current Fullness: %s" % currentFull)
			print ("Current Indigestion: %s" % currentIndigest)
			print("Player can't eat right now")
	else:
		print("Food Is Null")

func time_left_until_eat():
	var time_left = indigest_cooldown_timer.time_left
	var second = int(time_left) % 60
	return second

func _on_indigestion_cooldown_timer_timeout():
	currentIndigest -= indigest_reduction_amount
	print ("Current Indigestion: %s" % currentIndigest)
	if (currentIndigest >= maxIndigest):
		print ("Player's indigiestion is too high gotta wait")
		indigest_cooldown_timer.start()
	else:
		print ("Player indigiestion is low enough to eat again")
		canEat = true
		indigest_cooldown_timer.stop()
