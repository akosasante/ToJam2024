extends Control

@export var numAvailableDishes: int = 9
@export var numDishesPerRow: int = 3

static var menuItemScene: PackedScene = preload("res://ipad_menu/ipad_menu_item.tscn")


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

        var image: Texture2D = load(path)
        instantiateDishMenuImage(gridContainer, image, "SUSHI #%s" % n)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass


# initialize the grid container with a number of columns based on number of dishes
# for now, let's say that we want to show max 3 dishes per row, so we'll divide numDishes by 3 to get numColumns
func intializeNumberGridColumns(gridContainer: GridContainer, numDishes: int, perRow: int):
    var numColumns: int = numDishes / perRow
    gridContainer.columns = numColumns


func instantiateDishMenuImage(gridContainer: GridContainer, image: Texture2D, name: String):
    var loadedMenuItem: IpadMenuItem = menuItemScene.instantiate().with_data(image)
    loadedMenuItem.name = name
    gridContainer.add_child(loadedMenuItem)
