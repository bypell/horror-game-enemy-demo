extends State
class_name EnemyState

@onready var enemy := owner # owner is the root of our enemy scene (the CharacterBody3D node)
@onready var nav_agent := %NavigationAgent3D
@onready var anim_tree := %AnimationTree


func enter(previous_state_name: String, data := {}) -> void:
	pass


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass
