extends FoodButton
class_name ShrimpTempura

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	
	if (foodStats == null):
		load_stats(MenuGlobals.food_items["ShrimpTempura"] as Food)
	
	if (foodStats == null):
		fullness = 10
		indigestion = 8
		food_value = 6
		food_name = 'Shrimp Tempura'
		isWater = false
		food_id = "ShrimpTempura"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
