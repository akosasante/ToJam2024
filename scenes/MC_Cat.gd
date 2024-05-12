extends Sprite2D

@onready var normal_cat_sprite = preload("res://assets/images/mc_cat_default.png")
@onready var full_cat_sprite = preload("res://assets/images/mc_cat_indigestion.png")
@onready var indigested_cat_sprite = preload("res://assets/images/mc_cat_spicy.png")
@onready var player = $"../Table/Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	player.player_is_full.connect(_animate_to.bind(full_cat_sprite))
	player.player_is_indigested.connect(_animate_to.bind(indigested_cat_sprite))
	player.player_no_longer_indigested.connect(_animate_to.bind(normal_cat_sprite))

func _animate_to(texture: Resource):
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.35).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(_complete_animation.bind(texture))
	tween.play()
	

func _complete_animation(texture: Resource):
	self.texture = texture
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.5).set_trans(Tween.TRANS_LINEAR)
	tween.play()
