extends Node2D

@onready var player := $"../Table/Player"
@onready var hungerBar: TextureProgressBar = $hunger_bar
@onready var indigestionBar: TextureProgressBar = $indigestion_bar

# Called when the node enters the scene tree for the first time.
func _ready():
	player.player_consumed_something.connect(_on_player_consumption)
	hungerBar.value = 0
	indigestionBar.value = 0
	pass # Replace with function body.


func _on_player_consumption(food):
	print(food)
	
	hungerBar.value += food.fullness
	indigestionBar.value += food.indigestion
