extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var score_text := """You ate {num_dishes} dishes!
	
	Value of dishes: ${total_value}
	
	Score: {score}
	
	{extra_comment}
	""".format(format_score_text())
	
	$Label.visible_ratio = 0
	$Label.text = score_text
	
	var tween = create_tween()
	tween.tween_property($Label, "visible_ratio", 1, 5.0)
	tween.set_trans(Tween.TRANS_CUBIC)


func format_score_text() -> Dictionary:
	var foods_eaten: Array[Food] = MenuGlobals.foods_eaten
	var total_value                      = foods_eaten.reduce(func(accum: int, entry: Food): return accum + entry.food_value, 0)
	var score_and_comment: Array[String] = generate_score(total_value)
	
	return {
		"num_dishes": foods_eaten.size(),
		"total_value": total_value,
		"score": score_and_comment[0],
		"extra_comment": score_and_comment[1]
	}

func generate_score(total_value: int) -> Array[String]:
	if total_value < 10:
		return ["D+", "That's it?! What a noob! Come back anytime :)"]
	elif total_value < 50:
		return ["B", "Wow, pretty good, glad you liked the food :)"]
	else:
		return ["S", "Wow! You really must have been starving!"]

func _on_play_again_pressed():
	# Warn: gotta keep this as load, rather than preload which would be a bit more perfomrant because it seems to be messing with Godot's caching
	# https://github.com/godotengine/godot/issues/80981
	var game_scene := load("res://scenes/game.tscn")
	MenuGlobals.reset_all()
	SceneTransition.change_scene_with_dissolve(game_scene)


func _on_exit_pressed():
	print_debug("QUITTING")
	# TODO Maybe we play a sound here?
	get_tree().quit()
