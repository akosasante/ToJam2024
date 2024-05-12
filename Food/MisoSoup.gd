extends FoodButton
class_name MisoSoup

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	
	if (foodStats == null):
		load_stats(MenuGlobals.food_items["MisoSoup"] as Food)
	
	if (foodStats == null):
		fullness = 8
		indigestion = -2
		food_value = 5
		food_name = 'Miso Soup'
		isWater = false
		food_id = "MisoSoup"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
