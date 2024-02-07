extends Area2D
class_name Enterable

@export var scene_to_enter: String

func enter():
	TransitionLayer.change_scene(scene_to_enter)
