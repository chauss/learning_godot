extends Node2D
class_name LevelParent

const arrow_scene: PackedScene = preload("res://scenes/objects/projectiles/arrow.tscn")
const fireball_scene: PackedScene = preload("res://scenes/objects/projectiles/fireball.tscn")

@onready var projectiles := $Projectiles
@onready var player := $Player
@onready var enterables := $Enterables


func _on_player_player_shot(pos):
	var arrow = arrow_scene.instantiate()
	arrow.position = pos
	arrow.direction = player.global_position.direction_to(get_global_mouse_position())
	projectiles.add_child(arrow)


func _on_player_player_fireball(pos, dir):
	var fireball = fireball_scene.instantiate()
	fireball.position = pos
	fireball.direction = dir
	projectiles.add_child(fireball)


func _on_player_player_wants_to_enter():
	var allEnterables = enterables.get_children()
	
	for enterable in allEnterables:
		if enterable is Enterable:
			for body in enterable.get_overlapping_bodies():
				if body is Player:
					enterable.enter()
