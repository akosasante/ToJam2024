extends Control

@export var numAvailableDishes: int = 9
@export var numDishesPerRow: int = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	var gridContainer: GridContainer = $Panel/GridContainer
	print_debug("Got Grid: ", gridContainer)

	# Initialize the shape of the grid
	intializeNumberGridColumns(gridContainer, numAvailableDishes, numDishesPerRow)

	# populate the menu with my test sushi images
	for n in range(1, numAvailableDishes + 1):
		var path: String = "res://akosua_test_images/sushi%s.png" % n
		print_debug("path: ", path)

		var canvasSprite: TextureRect = TextureRect.new()
		canvasSprite.texture = load(path)
		instantiateDishMenuImage(gridContainer, canvasSprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# initialize the grid container with a number of columns based on number of dishes
# for now, let's say that we want to show max 3 dishes per row, so we'll divide numDishes by 3 to get numColumns
func intializeNumberGridColumns(gridContainer: GridContainer, numDishes: int, perRow: int):
	var numColumns: int = numDishes / perRow
	gridContainer.columns = numColumns


func instantiateDishMenuImage(gridContainer: GridContainer, image: Node):
	gridContainer.add_child(image)
	
