extends Control

@export var numAvailableDishes: int = 9
@export var numDishesPerRow: int

static var menuItemScene: PackedScene = preload("res://ipad_menu/ipad_menu_item.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var gridContainer: GridContainer = $Panel/GridContainer
	print_debug("Got Grid: ", gridContainer)

	# Initialize the shape of the grid
	intializeNumberGridColumns(gridContainer, numDishesPerRow)

	# populate the menu with my test sushi images
	for n in range(1, numAvailableDishes + 1):
		var path: String = "res://akosua_test_images/sushi%s.png" % n
		print_debug("path: ", path)

		var image: Texture2D = load(path)
		instantiateDishMenuImage(gridContainer, image, "SUSHI #%s" % n)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# initialize the grid container with a number of columns based on how we want to arrange the rows/columns
func intializeNumberGridColumns(gridContainer: GridContainer, perRow: int):
	gridContainer.columns = perRow


func instantiateDishMenuImage(gridContainer: GridContainer, image: Texture2D, name: String):
	var loadedMenuItem: IpadMenuItem = menuItemScene.instantiate().with_data(image)
	loadedMenuItem.name = name
	gridContainer.add_child(loadedMenuItem)
