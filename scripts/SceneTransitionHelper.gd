extends CanvasLayer

var scene_to_change_to: PackedScene
var playing_forwards: bool

func change_scene_with_dissolve(target: PackedScene) -> void:
	self.show()
	scene_to_change_to = target
	$dissolve_rect.visible = true
	playing_forwards = true
	$AnimationPlayer.play('dissolve')

func _on_animation_player_animation_finished(anim_name):
	if scene_to_change_to and playing_forwards:
		playing_forwards = false
		get_tree().change_scene_to_packed(scene_to_change_to)
		$AnimationPlayer.play_backwards('dissolve')
	else:
		self.hide()
