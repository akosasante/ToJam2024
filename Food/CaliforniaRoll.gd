extends FoodButton
class_name CaliforniaRoll

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	
	if (foodStats == null):
		load_stats(MenuGlobals.food_items["CaliforniaRoll"] as Food)
			
	if (foodStats == null):
		fullness = 8
		indigestion = 2
		food_value = 8
		food_name = 'California Roll'
		isWater = false
		food_id = "CaliforniaRoll"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
