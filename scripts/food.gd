extends TextureButton
class_name Food

@export var fullness : int

@export var indigestion : int

@export var food_value : int

@export var food_name : String

@export var isWater : bool = false

signal food_eaten(food)

func with_data(given_image: Texture2D) -> Food:
	texture_normal = given_image
	return self
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func _on_pressed():
	var s = ""
	if isWater:
		s ="Drinking"
	else:
		s = "Eating"
				
	print("%s %s" % [s, food_name])
	food_eaten.emit(self)
	if (!isWater):
		queue_free()
