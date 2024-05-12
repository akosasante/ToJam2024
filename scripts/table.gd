extends Node2D

@export var numDishesPerRow: int

static var foodScene: PackedScene = preload("res://scenes/food.tscn")

@onready var food_container: GridContainer = $FoodContainer

@onready var food_area: ReferenceRect = $FoodArea

signal food_ready

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("Got FoodButton Grid: ", food_container)
	MenuGlobals.food_on_table_updated.connect(_food_on_table_updated)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updateFoodContainer():
	# first remove any existing food items from the grid
	for node in food_container.get_children():
		food_container.remove_child(node)
		node.queue_free()
		
	intializeNumberGridColumns(food_container, numDishesPerRow)

	for food_Key in MenuGlobals.foods_on_table:
		var food: Food = MenuGlobals.food_items[food_Key] as Food
		
		var amount = MenuGlobals.foods_on_table[food_Key]
		
		var amountOnPlates: int = 0
		
		if (food_area != null):
			var food_on_plate: Array = getFoodsOnPlates()
			for platedFood in food_on_plate:
				if ((platedFood as FoodButton).foodStats.food_name == food.food_name):
					amountOnPlates += 1
		
		var needAmount = amount - amountOnPlates
		
		if (amountOnPlates != amount):
			for n in range(1, needAmount + 1):
				instantiateFoodMenuImage(food_container, food)
				#var path: String = MenuGlobals.foods_image_dict[food_Key]
				#print_debug("path: ", path)
	#
				#var image: Texture2D = load(path)
				#instantiateDishMenuImage(food_container, image, "%s - %s" % [food_Key, n], food_Key)
			
	food_ready.emit()

# initialize the grid container with a number of columns based on how we want to arrange the rows/columns
func intializeNumberGridColumns(gridContainer: GridContainer, perRow: int):
	gridContainer.columns = perRow

func instantiateDishMenuImage(gridContainer: GridContainer, image: Texture2D, name: String, id: String):
	var foodButton: FoodButton = foodScene.instantiate().with_data(name)
	foodButton.food_name = id
	foodButton.name = name
	foodButton.food_id = id
	foodButton.isWater = false
	
	gridContainer.add_child(foodButton)
	
func instantiateFoodMenuImage(gridContainer: GridContainer, food: Food):
	var foodButton: FoodButton = foodScene.instantiate().load_data(food)
	if (food_area == null):
		gridContainer.add_child(foodButton)
	else :
		spawnFoodButton(foodButton)
		
	foodButton.scale = Vector2(2, 2)
	
func spawnFoodButton(foodButton: FoodButton) -> bool:
	for child in food_area.get_children():
		if (child.name.contains("Plate")):
			if (child.get_children().is_empty()):
				child.add_child(foodButton)
				return true;
	return false

func getFoodsOnPlates() -> Array:
	var platedFoods: Array[Variant] = []
	for child in food_area.get_children():
		if (child.name.contains("Plate")):
			if !child.get_children().is_empty():
				var plateChild: Node = child.get_child(0)
				if (plateChild != null && (plateChild is TextureButton)):
					var platedFood: FoodButton = plateChild as FoodButton
					if (platedFood != null):
						platedFoods.push_back(platedFood)
					
	return platedFoods
	
func _food_on_table_updated():
	updateFoodContainer()
