extends TextureRect
class_name IpadMenuItem

@export var image: Texture2D

const DARKEN_OVERLAY := Color(0.8, 0.8, 0.8, 1.0)
const HOVER_OVERLAY :=  Color(1.0, 1.0, 1.0, 1.0)


# We willl be instantiating this scene/object from the IpadMenu one
# so we want to be able to let that parent object pass in some info about
# what menu item this is. 
# got this approach from: https://www.reddit.com/r/godot/comments/13pm5o5/comment/kxvpbex/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
func with_data(given_image: Texture2D) -> IpadMenuItem:
	texture = given_image
	self.modulate = DARKEN_OVERLAY # initialize with a slightly off-white overlay
	return self


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


#### SIGNALS ####

# When mouse enters this menu item,
# Darken the image and show a border
# Display up/down arrows
func _on_mouse_entered():
	print("MOUSE ENTERED %s" % name)
	self.modulate = HOVER_OVERLAY  # Reset to original color


# When mouse exits this menu item
# undarken the image and hide border
# hide the up/down arrows
func _on_mouse_exited():
	print("MOUSE EXITED %s" % name)
	self.modulate = DARKEN_OVERLAY # Reset to darkened color
