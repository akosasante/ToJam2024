extends Sprite2D

@onready var food = $".."
@onready var player = $"../../Player"

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if get_rect().has_point(to_local(event.position)):
				print("Eating %s" % food.name)
				player.eat_food(food)
