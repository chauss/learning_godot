extends Node2D

const arrow_scene: PackedScene = preload("res://scenes/objects/projectiles/arrow.tscn")
const fireball_scene: PackedScene = preload("res://scenes/objects/projectiles/fireball.tscn")


func _on_player_player_shot(pos):
	var arrow = arrow_scene.instantiate()
	arrow.position = pos
	arrow.direction = $Player.global_position.direction_to(get_global_mouse_position())
	$Projectiles.add_child(arrow)


func _on_player_player_fireball(pos, dir):
	var fireball = fireball_scene.instantiate()
	fireball.position = pos
	fireball.direction = dir
	$Projectiles.add_child(fireball)
