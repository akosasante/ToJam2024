extends Control

@export var numAvailableDishes: int = 9
@export var numDishesPerRow: int

static var menuItemScene: PackedScene = preload("res://ipad_menu/scenes/ipad_menu_item.tscn")

var foods_in_menu: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	MenuGlobals.load_food_resources()
	MenuGlobals.reset_remaining_capacity()
	
	var gridContainer: GridContainer = $Panel/MarginContainer/GridContainer
	print_debug("Got Grid: ", gridContainer)

	# Initialize the shape of the grid
	intializeNumberGridColumns(gridContainer, numDishesPerRow)

	for food_key in MenuGlobals.food_items:
		var food_stats: Food = MenuGlobals.food_items[food_key] as Food
		instantiateFoodMenuImage(gridContainer, food_stats)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# initialize the grid container with a number of columns based on how we want to arrange the rows/columns
func intializeNumberGridColumns(gridContainer: GridContainer, perRow: int):
	gridContainer.columns = perRow


func instantiateDishMenuImage(gridContainer: GridContainer, image: Texture2D, name: String):
	var loadedMenuItem: IpadMenuItem = menuItemScene.instantiate().with_data(image, name)
	loadedMenuItem.name = name
	loadedMenuItem.increment_food_item.connect(_on_increment_food_item)
	loadedMenuItem.decrement_food_item.connect(_on_decrement_food_item)
	gridContainer.add_child(loadedMenuItem)
	
func instantiateFoodMenuImage(gridContainer: GridContainer, food: Food):
	var loadedMenuItem: IpadMenuItem = menuItemScene.instantiate().load_data(food)
	loadedMenuItem.name = food.food_name
	loadedMenuItem.increment_food_item.connect(_on_increment_food_item)
	loadedMenuItem.decrement_food_item.connect(_on_decrement_food_item)
	gridContainer.add_child(loadedMenuItem)
	
	
func _on_decrement_food_item(food_name: String):
	print("DECREMENTING %s" % food_name)
	if foods_in_menu.has(food_name):
		foods_in_menu[food_name] -= 1
		
		if foods_in_menu[food_name] == 0:
			foods_in_menu.erase(food_name)
	
	MenuGlobals.remaining_capacity_change(1)
	
	
	
func _on_increment_food_item(food_name: String):
	print("INCREMENTING %s" % food_name)
	
	if foods_in_menu.has(food_name):
		foods_in_menu[food_name] += 1
	else:
		foods_in_menu[food_name] = 1
		
	MenuGlobals.remaining_capacity_change(-1)
	

func _on_confirm_button_pressed():
	MenuGlobals.update_food_on_table(foods_in_menu)
	self.queue_free()


func _on_cancel_button_pressed():
	MenuGlobals.reset_remaining_capacity()
	MenuGlobals.food_on_table_updated.emit()
	self.queue_free()
