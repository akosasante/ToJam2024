extends Node2D

@export var numDishesPerRow: int

static var foodScene: PackedScene = preload("res://scenes/food.tscn")

@onready var food_container = $FoodContainer

signal food_ready

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("Got Food Grid: ", food_container)
	MenuGlobals.food_on_table_updated.connect(_food_on_table_updated)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updateFoodContainer():
	intializeNumberGridColumns(food_container, numDishesPerRow)

	for sushiKey in MenuGlobals.foods_on_table:
		for n in range(1, MenuGlobals.foods_on_table[sushiKey] + 1):
			var path: String = MenuGlobals.foods_image_dict[sushiKey]
			print_debug("path: ", path)

			var image: Texture2D = load(path)
			instantiateDishMenuImage(food_container, image, "%s - %s" % [sushiKey, n], sushiKey)
			
	food_ready.emit()

# initialize the grid container with a number of columns based on how we want to arrange the rows/columns
func intializeNumberGridColumns(gridContainer: GridContainer, perRow: int):
	gridContainer.columns = perRow

func instantiateDishMenuImage(gridContainer: GridContainer, image: Texture2D, name: String, id: String):
	var loadedMenuItem: Food = foodScene.instantiate().with_data(image)
	loadedMenuItem.food_name = name
	loadedMenuItem.food_id = id
	loadedMenuItem.isWater = false
	gridContainer.add_child(loadedMenuItem)


func _food_on_table_updated():
	updateFoodContainer()
