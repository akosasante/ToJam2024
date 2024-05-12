extends Control
class_name IpadMenuItem

@onready var menu_item_image := $VBoxContainer/menu_item_image

@onready var menu_item_dish_name = $VBoxContainer/menu_item_dish_name

@onready var menu_item_attributes = $VBoxContainer/menu_item_attributes
@onready var menu_item_fullness = $VBoxContainer/menu_item_attributes/menu_item_fullness
@onready var menu_item_value = $VBoxContainer/menu_item_attributes/menu_item_value
@onready var menu_item_indigestion = $VBoxContainer/menu_item_attributes/menu_item_indigestion

@onready var label :=  $VBoxContainer/menu_item_buttons/Label
@onready var down_arrow := $VBoxContainer/menu_item_buttons/menu_item_button_down
@onready var up_arrow := $VBoxContainer/menu_item_buttons/menu_item_button_up

var menu_food : Food
var food_name: String
var food_id: String

signal increment_food_item
signal decrement_food_item

# We willl be instantiating this scene/object from the IpadMenu one
# so we want to be able to let that parent object pass in some info about
# what menu item this is. 
# got this approach from: https://www.reddit.com/r/godot/comments/13pm5o5/comment/kxvpbex/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

# TODO: Replace this with a FoodButton class/Resource
func with_data(given_image: Texture2D, name: String) -> IpadMenuItem:
	if menu_item_image == null:
		menu_item_image = $VBoxContainer/menu_item_image

	menu_item_image.texture = given_image
	food_name = name
	food_id = name
	
	return self
	

func load_data(food: Food) -> IpadMenuItem:
	if menu_item_image == null:
		menu_item_image = $VBoxContainer/menu_item_image
	
	menu_food = food
	menu_item_image.texture = food.image
	food_name = food.food_name
	food_id = food.food_id
	
	return self


# Called when the node enters the scene tree for the first time.
func _ready():
	MenuGlobals.remaining_capacity_changed.connect(_on_remaining_capacity_changed)
	update_button_states()
	
	if (food_name):
		menu_item_dish_name.text = food_name
		
	if (menu_food):
		menu_item_attributes.visible = true
		
		var filling = menu_food.fullness
		if (filling == 0):
			menu_item_fullness.visible = false
		else:
			menu_item_fullness.visible = true
			if (filling < 10):
				menu_item_fullness.texture = load("res://assets/images/full1.png")
			elif (filling >= 10 && filling < 15):
				menu_item_fullness.texture = load("res://assets/images/full2.png")
			else:
				menu_item_fullness.texture = load("res://assets/images/full3.png")
		
		var value = menu_food.food_value
		if (value == 0):
			menu_item_value.visible = false
		else:
			menu_item_value.visible = true
			if (value < 10):
				menu_item_value.texture = load("res://assets/images/value1.png")
			elif (value >= 10 && value < 20):
				menu_item_value.texture = load("res://assets/images/value2.png")
			else:
				menu_item_value.texture = load("res://assets/images/value3.png")
		
		var indigestion = menu_food.indigestion
		if (indigestion == 0):
			menu_item_indigestion.visible = false
		else:
			menu_item_indigestion.visible = true
			if (indigestion < 10):
				menu_item_indigestion.texture = load("res://assets/images/indigestion1.png")
			elif (indigestion >= 10 && indigestion < 20):
				menu_item_indigestion.texture = load("res://assets/images/indigestion2.png")
			else:
				menu_item_indigestion.texture = load("res://assets/images/indigestion3.png")
	else:
		menu_item_attributes.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	
func update_button_states():
	if MenuGlobals.remaining_capacity == 0:
		up_arrow.disabled = true
	elif up_arrow.disabled:
		up_arrow.disabled = false

#### SIGNALS ####

# If remaining capacity changes (due to other menu items or changes on table)
# We should update the buttons here to disable if needed
func _on_remaining_capacity_changed():
	update_button_states()

func _on_menu_item_button_up_pressed():
	print_debug("up button pressed")
	if MenuGlobals.remaining_capacity > 0:
		var new_amount: int = int(label.text) + 1
		label.text = str(new_amount)
		# Eventually we'd want to update this to also include the food name
		increment_food_item.emit(food_id)
		if down_arrow.disabled:
			down_arrow.disabled = false
		

func _on_menu_item_button_down_pressed():
	print_debug("down button pressed")
	var curr_amount: int = int(label.text)
	if curr_amount > 0:
		if curr_amount == 1:
			down_arrow.disabled = true
			
		label.text = str(curr_amount - 1)
		decrement_food_item.emit(food_id)
		
