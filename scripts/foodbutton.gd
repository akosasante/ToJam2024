extends TextureButton
class_name FoodButton

@export var foodStats : Food = null

@export var fullness : int

@export var indigestion : int

var food_id : String

@export var food_value : int

@export var food_name : String

@export var isWater : bool = false

@export var deathChance : float = 0.0

var image : Texture2D

@export var sound_effect : AudioStreamMP3

var food_sound_effect_player : AudioStreamPlayer

signal food_eaten(food)

func with_data(given_image: Texture2D) -> FoodButton:
	texture_normal = given_image
	return self
	
func load_data(food: Food) -> FoodButton:
	foodStats = food
	return self

# Called when the node enters the scene tree for the first time.
func _ready():
	load_stats(foodStats)
	
	if image:
		ignore_texture_size = true
		stretch_mode = STRETCH_SCALE
		custom_minimum_size = Vector2(100, 100)
		
		if (isWater):
			food_sound_effect_player = $"../../FoodSoundEffectPlayer"
		else:
			food_sound_effect_player = $"../../../../FoodSoundEffectPlayer"
			
func load_stats(food: Food):
	if (food != null):
		fullness = food.fullness
		indigestion = food.indigestion
		food_value = food.food_value
		food_name = food.food_name
		food_id = food.food_id
		isWater = food.isWater
		image = food.image
		texture_normal = image
		deathChance = food.deathChance
		sound_effect = food.consumtionSound
	
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
	
	# Player will get the food object and will handle removing it from the table if they were actually able to eat it
	food_eaten.emit(self)

func play_sound_effect():
	if (sound_effect && food_sound_effect_player):
		food_sound_effect_player.stream = sound_effect
		food_sound_effect_player.volume_db = 10
		food_sound_effect_player.play(0.38)
		
func stop_sound_effect():
	if (food_sound_effect_player && food_sound_effect_player.playing):
		food_sound_effect_player.stop()
