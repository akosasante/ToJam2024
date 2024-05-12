extends FoodButton
class_name Pufferfish

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	
	if (foodStats == null):
		load_stats(MenuGlobals.food_items["Pufferfish"] as Food)
	
	if (foodStats == null):
		fullness = 10
		indigestion = 25
		food_value = 100
		food_name = 'Pufferfish'
		isWater = false
		food_id = "Pufferfish"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
