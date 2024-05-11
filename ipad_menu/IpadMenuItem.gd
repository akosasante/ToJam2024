extends Control
class_name IpadMenuItem

var menu_item_image: TextureRect
var label: Label
var remaining_capacity: int = 9


signal increment_food_item
signal decrement_food_item

# We willl be instantiating this scene/object from the IpadMenu one
# so we want to be able to let that parent object pass in some info about
# what menu item this is. 
# got this approach from: https://www.reddit.com/r/godot/comments/13pm5o5/comment/kxvpbex/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
func with_data(given_image: Texture2D) -> IpadMenuItem:
	if menu_item_image == null:
		menu_item_image = $VBoxContainer/Control/menu_item_image

	menu_item_image.texture = given_image
	return self


# Called when the node enters the scene tree for the first time.
func _ready():
	label = $VBoxContainer/menu_item_buttons/Label
	if menu_item_image == null:
		menu_item_image = $VBoxContainer/Control/menu_item_image


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


#### SIGNALS ####



func _on_menu_item_button_up_pressed():
	print_debug("up button pressed")
	if remaining_capacity > 0:
		var new_amount: int = int(label.text) + 1
		label.text = str(new_amount)
		# Eventually we'd want to update this to also include the food name
		increment_food_item.emit()
		

func _on_menu_item_button_down_pressed():
	print_debug("down button pressed")
	var curr_amount: int = int(label.text)
	if curr_amount > 0:
		label.text = str(curr_amount - 1)
		decrement_food_item.emit()
