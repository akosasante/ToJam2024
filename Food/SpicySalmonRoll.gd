extends FoodButton
class_name SpicySalmonRoll

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	
	if (foodStats == null):
		load_stats(MenuGlobals.food_items["SpicySalmonRoll"] as Food)
	
	if (foodStats == null):
		fullness = 5
		indigestion = 10
		food_value = 12
		food_name = 'Spicy Salmon Roll'
		isWater = false
		food_id = "SpicySalmonRoll"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
