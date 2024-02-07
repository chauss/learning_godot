extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func change_scene(target: String) -> void:
	print("in change scene")
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target)
	animation_player.play("fade_to_transparent")
