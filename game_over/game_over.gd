extends Control

func _ready() -> void:
	%RestartButton.pressed.connect(_on_restart_pressed)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://level/level.tscn")
