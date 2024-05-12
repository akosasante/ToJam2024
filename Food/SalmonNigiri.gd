extends FoodButton
class_name SalmonNigiri

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	
	if (foodStats == null):
		load_stats(MenuGlobals.food_items["SalmonNigiri"] as Food)
	
	if (foodStats == null):
		fullness = 12
		indigestion = 1
		food_value = 15
		food_name = 'Salmon Nigiri'
		isWater = false
		food_id = "SalmonNigiri"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
