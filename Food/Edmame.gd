extends FoodButton
class_name Edamame

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	
	if (foodStats == null):
		load_stats(MenuGlobals.food_items["Edamame"] as Food)
	
	if (foodStats == null):
		fullness = 5
		indigestion = -2
		food_value = 5
		food_name = 'Edamame'
		isWater = false
		food_id = "Edamame"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
