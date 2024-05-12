extends FoodButton
class_name Water

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	
	if (foodStats == null):
		load_stats(load("res://resources/Water.tres") as Food)
	
	if (foodStats == null):
		fullness = 5
		indigestion = -5
		food_value = 0
		food_name = 'Water'
		isWater = true
		food_id = "Water"
		
	if image:
		ignore_texture_size = true
		stretch_mode = STRETCH_KEEP_ASPECT_CENTERED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
