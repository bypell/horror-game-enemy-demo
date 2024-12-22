class_name State extends Node

signal wanted_transition_to_other_state(next_state_path: String, data: Dictionary)


func enter(previous_state_name: String, data := {}) -> void:
	pass


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass
