extends Node

static var ipadMenu: PackedScene = preload("res://ipad_menu/scenes/ipad_menu.tscn")
		

func _on_order_more_pressed():
	print_debug("Opening ipad in middle of screen")
	var top_scene: Node = get_tree().current_scene
	var ipad := ipadMenu.instantiate()
	ipad.position = get_viewport().get_visible_rect().size / 2
	ipad.scale = Vector2(0.75, 0.75)
	top_scene.add_child(ipad)
