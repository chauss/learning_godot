extends Area2D
class_name Enterable

@export var scene_to_enter: PackedScene

func enter():
	get_tree().change_scene_to_packed(scene_to_enter)
