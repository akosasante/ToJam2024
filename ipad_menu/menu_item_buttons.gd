extends VBoxContainer

signal menu_item_increased
signal menu_item_decreased

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	

### SIGNALS ####
func _on_menu_item_button_up_pressed():
	print("Up button pressed")
	menu_item_increased.emit()

func _on_menu_item_button_down_pressed():
	print("Down button pressed")
	menu_item_decreased.emit()
	