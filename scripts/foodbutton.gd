extends TextureButton
class_name FoodButton

@export var foodStats : Food = null

@export var fullness : int

@export var indigestion : int

var food_id : String

@export var food_value : int

@export var food_name : String

@export var isWater : bool = false

var image : Texture2D

signal food_eaten(food)

func with_data(given_image: Texture2D) -> FoodButton:
	texture_normal = given_image
	return self
	
func load_data(food: Food) -> FoodButton:
	foodStats = food
	return self

# Called when the node enters the scene tree for the first time.
func _ready():
	load_stats(foodStats)
	
func load_stats(food: Food):
	if (food != null):
		fullness = food.fullness
		indigestion = food.indigestion
		food_value = food.food_value
		food_name = food.food_name
		food_id = food.food_id
		isWater = food.isWater
		image = food.image
		texture_normal = image
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func _on_pressed():
	var s = ""
	if isWater:
		s ="Drinking"
	else:
		s = "Eating"
				
	print("%s %s" % [s, food_name])
	food_eaten.emit(self)
	if (!isWater):
		MenuGlobals.update_food_on_table_amount(food_id)
		#MenuGlobals.remaining_capacity_change(1)
		queue_free()
