extends Node2D

@export var meal_charge: int = 25

var medalImages: Dictionary = {
								  "F": preload("res://assets/images/Ftier.png"),
								  "E": preload("res://assets/images/Etier.png"),
								  "D": preload("res://assets/images/Dtier.png"),
								  "C": preload("res://assets/images/Ctier.png"),
								  "B": preload("res://assets/images/Btier.png"),
								  "A": preload("res://assets/images/Atier.png"),
								  "S": preload("res://assets/images/Stier.png"),
							  }


# Called when the node enters the scene tree for the first time.
func _ready():
	var score_dict: Dictionary = format_score_text()
	
	var score_text := """You ate {num_dishes} dishes! Today's dinner charge was ${meal_charge}
	
	Value of finished dishes: ${reward_value}
	
	Uneaten dishes: {num_uneaten_dishes}
	
	Uneaten dishes pentalty: ${penalty_value}
	
	Value of dishes: ${total_value}
	
	Score: {score}
	
	{extra_comment}
	""".format(score_dict)

	$Label.visible_ratio = 0
	$Label.text = score_text
	
	$Medal.texture = medalImages[score_dict["score"]]

	var tween := create_tween()
	tween.tween_property($Label, "visible_ratio", 1, 5.0).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(_animate_badge)


func format_score_text() -> Dictionary:
	var foods_eaten: Array[Food] = MenuGlobals.foods_eaten
	var food_eaten_value = foods_eaten.reduce(func(accum: int, entry: Food): return accum + entry.food_value, 0)
	
	var foods_on_table : Array[Food]
	
	for food_Key in MenuGlobals.foods_on_table:
		var amount = MenuGlobals.foods_on_table[food_Key]
		for _n in range(amount):
			var food: Food = MenuGlobals.food_items[food_Key] as Food
			foods_on_table.push_back(food)
			
	var food_uneaten_value = foods_on_table.reduce(func(accum: int, entry: Food): return accum + entry.food_value, 0)
	
	var total_value = (food_eaten_value - food_uneaten_value) - 25
	
	var score_and_comment: Array[String] = generate_score(total_value)

	return {
		"num_dishes": foods_eaten.size(),
		"reward_value":food_eaten_value,
		"num_uneaten_dishes": foods_on_table.size(),
		"penalty_value": food_uneaten_value,
		"total_value": total_value,
		"score": score_and_comment[0],
		"extra_comment": score_and_comment[1],
		"meal_charge": meal_charge
	}


func generate_score(total_value: int) -> Array[String]:
	if total_value <= 0:
		return ["F", "Much bad"]
	elif total_value < 25:
		return ["E", "That's it?! What a noob! Come back anytime :)"]
	elif total_value < 50:
		return ["D", "Meh"]
	elif total_value < 100:
		return ["C", "Okay you're doing something"]
	elif total_value < 200:
		return ["B", "Wow, pretty good, glad you liked the food :)"]
	elif total_value < 300:
		return ["A", "You ate, girl!"]
	else:
		return ["S", "Wow! You really must have been starving!"]


func _animate_badge():
	$Medal/AnimationPlayer.current_animation = "medal_appear"


func _on_play_again_pressed():
	# Warn: gotta keep this as load, rather than preload which would be a bit more perfomrant because it seems to be messing with Godot's caching
	# https://github.com/godotengine/godot/issues/80981
	var game_scene := load("res://scenes/game.tscn")
	MenuGlobals.reset_all()
	SceneTransition.change_scene_with_dissolve(game_scene)
	
func _on_return_to_main_menu_pressed():
	# Warn: gotta keep this as load, rather than preload which would be a bit more perfomrant because it seems to be messing with Godot's caching
	# https://github.com/godotengine/godot/issues/80981
	var main_menu_scene := load("res://main_menu/main_menu.tscn")
	# Reset global values
	MenuGlobals.reset_all()
	SceneTransition.change_scene_with_dissolve(main_menu_scene)

func _on_exit_pressed():
	print_debug("QUITTING")
	# TODO Maybe we play a sound here?
	get_tree().quit()
