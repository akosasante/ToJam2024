extends Node2D

@export var numDishesPerRow: int

static var foodScene: PackedScene = preload("res://scenes/food.tscn")

@onready var food_container = $FoodContainer

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
		var food = MenuGlobals.food_items[food_Key] as Food
		for n in range(1, MenuGlobals.foods_on_table[food_Key] + 1):
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
	var loadedMenuItem: FoodButton = foodScene.instantiate().with_data(name)
	loadedMenuItem.food_name = id
	loadedMenuItem.name = name
	loadedMenuItem.food_id = id
	loadedMenuItem.isWater = false
	
	gridContainer.add_child(loadedMenuItem)
	
func instantiateFoodMenuImage(gridContainer: GridContainer, food: Food):
	var loadedMenuItem: FoodButton = foodScene.instantiate().load_data(food)
	gridContainer.add_child(loadedMenuItem)


func _food_on_table_updated():
	updateFoodContainer()
