extends Node2D

const maxFull: int   = 100
var currentFull: int = 0

@onready var isFull: bool = false
const maxIndigest: int   = 100
var currentIndigest: int = 0

@onready var hasIndigestion: bool = false

@export var indigest_reduction_amount: int = 10
@export var indigest_cooldown_wait_time: int = 10

@onready var indigest_cooldown_timer: Timer = $IndigestionCooldownTimer
@onready var canEat: bool = true

var water: FoodButton

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
static var deathScene: PackedScene = preload("res://scenes/unalive_screen.tscn")

signal player_consumed_something


# Called when the node enters the scene tree for the first time.
func _ready():
	indigest_cooldown_timer.wait_time = indigest_cooldown_wait_time

	print ("Max Fullness: %s" % maxFull)
	print ("Current Fullness: %s" % currentFull)

	print ("Max Indigestion: %s" % maxIndigest)
	print ("Current Indigestion: %s" % currentIndigest)

	var res: Array[Variant] = []
	MenuGlobals.findAllFoods(get_tree().current_scene, res)
	for food in res:
		if food.isWater:
			water = food
			break

	if (water):
		water.food_eaten.connect(_on_kwasi_test_water_food_eaten)

var timeVar: int = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!canEat && indigest_cooldown_timer.time_left > 0):
		timeVar += delta
		if (timeVar >= 1):
			print ("Time Left Until Indigestion Goes Down: %s" % time_left_until_eat())
			timeVar = 0
	pass


func _on_table_food_ready():
	var res: Array[FoodButton] = []
	MenuGlobals.findAllFoods(get_tree().current_scene, res)
	for food in res:
		if !food.isWater:
			food.food_eaten.connect(_on_kwasi_test_food_food_eaten)


func _on_kwasi_test_food_food_eaten(food):
	eat_drink_food(food, false)


func _on_kwasi_test_water_food_eaten(food):
	eat_drink_food(food, true)


func eat_drink_food(food: FoodButton, isWater: bool) -> void:
	if (food):
		canEat = (isWater && !isFull) || (!isFull && !hasIndigestion)
		if (canEat):
			# handle chance of randomly badly prepared pufferfish
			var deathRng: float = rng.randf_range(0.0, 100.0)
			if deathRng < food.deathChance:
				SceneTransition.change_scene_with_dissolve(deathScene)
			
		#handle fullness
			currentFull += food.fullness
			if (currentFull >= maxFull):
				currentFull = maxFull
			
			# handle indigestion
			currentIndigest += food.indigestion           
			if (currentIndigest >= maxIndigest):
				currentIndigest = maxIndigest
			
			print ("Current Fullness: %s" % currentFull)
			print ("Current Indigestion: %s" % currentIndigest)

			if (currentFull >= maxFull):
				currentFull = maxFull
				isFull = true;
				print("Player Is Now FULL!!!!!!!!!!!!!!!!!!!!!!!!")
			else:
				if (isWater):
					print("Drinking Water")
				if (isWater && hasIndigestion):
					hasIndigestion = false
					print("Player Can Eat Now")
					if (indigest_cooldown_timer.time_left > 0):
						indigest_cooldown_timer.stop()
				elif (currentIndigest >= maxIndigest):
					currentIndigest = maxIndigest
					hasIndigestion = true
					indigest_cooldown_timer.start()
					print("You got indigestion. Wait until it goes down before eating")
		
			# side effects
			player_consumed_something.emit(food.foodStats)
			if (!isWater):
				# We were able to eat it, so update the amount on table and delete the food
				# also record that we successfully ate so we have it for the final scoring
				MenuGlobals.foods_eaten.push_back(food.foodStats)
				MenuGlobals.remove_food_from_table(food.food_id)
				food.queue_free()
		else:
			print ("Current Fullness: %s" % currentFull)
			print ("Current Indigestion: %s" % currentIndigest)
			print("Player can't eat right now")
	else:
		print("FoodButton Is Null")


func time_left_until_eat():
	var time_left: float = indigest_cooldown_timer.time_left
	var second: int      = int(time_left) % 60
	return second


func _on_indigestion_cooldown_timer_timeout():
	currentIndigest -= indigest_reduction_amount
	print ("Current Indigestion: %s" % currentIndigest)
	if (currentIndigest >= maxIndigest):
		print ("Player's indigiestion is too high gotta wait")
		indigest_cooldown_timer.start()
	else:
		print ("Player indigiestion is low enough to eat again")
		hasIndigestion = false
		indigest_cooldown_timer.stop()
