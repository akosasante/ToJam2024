extends Resource
class_name Food

@export var fullness : int

@export var indigestion : int

@export var food_value : int

@export var food_name : String

@export var food_id : String

@export var isWater : bool = false

@export var image : Texture2D

@export var deathChance : float = 0.0

@export var consumtionSound : AudioStreamMP3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
