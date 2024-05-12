extends Node2D

@onready var player := $"../Table/Player"
@onready var indigestionCooldownTimer: Timer = $"../Table/Player/IndigestionCooldownTimer"
@onready var hungerBar: TextureProgressBar = $hunger/hunger_bar
@onready var indigestionBar: TextureProgressBar = $indigestion/indigestion_bar

# Called when the node enters the scene tree for the first time.
func _ready():
	player.player_consumed_something.connect(_on_player_consumption)
	hungerBar.value = 0
	indigestionBar.value = 0


func _on_player_consumption(food: Food):
	hungerBar.value += food.fullness
	indigestionBar.value += food.indigestion
	
func _on_player_indigestion():
	indigestionBar.value -= player.indigest_reduction_amount
