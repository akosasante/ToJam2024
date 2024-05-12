extends Node

static var ipadMenu: PackedScene = preload("res://ipad_menu/scenes/ipad_menu.tscn")
@onready var button = $"."	

func _ready():
	MenuGlobals.food_on_table_updated.connect(_on_food_submitted)

func _on_order_more_pressed():
	print_debug("Opening ipad in middle of screen")
	
	var top_scene: Node = get_tree().current_scene
	var ipad := ipadMenu.instantiate()

	ipad.scale = Vector2(1.5, 1.5)
	top_scene.add_child(ipad)
	button.disabled = true

	
func _on_food_submitted():
	button.disabled = false
