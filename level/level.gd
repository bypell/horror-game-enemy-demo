extends Node3D


func _ready() -> void:
	var enemy: Enemy = get_tree().get_first_node_in_group("enemy")
	enemy.reached_player.connect(_enemy_reached_player)


func _enemy_reached_player() -> void:
	get_tree().change_scene_to_file("res://game_over/game_over.tscn")
