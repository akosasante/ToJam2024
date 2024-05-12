extends FoodButton
class_name SalmonSashimi

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	
	if (foodStats == null):
		load_stats(MenuGlobals.food_items["SalmonSashimi"] as Food)
	
	if (foodStats == null):
		fullness = 15
		indigestion = 1
		food_value = 25
		food_name = 'Salmon Sashimi'
		isWater = false
		food_id = "SalmonSashimi"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
