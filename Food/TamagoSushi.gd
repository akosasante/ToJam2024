extends FoodButton
class_name TamagoSushi

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	
	if (foodStats == null):
		load_stats(MenuGlobals.food_items["TamagoSushi"] as Food)
	
	if (foodStats == null):
		fullness = 6
		indigestion = 1
		food_value = 7
		food_name = 'Tamago Sushi'
		isWater = false
		food_id = "TamagoSushi"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
