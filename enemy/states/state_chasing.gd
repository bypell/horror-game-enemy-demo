extends EnemyState

@export var chase_max_time := 8.0
@export var update_path_delay := 0.0 # if you do not want to update the path every physics frame, increase this
@export var _chasing_speed := 6.0
@export var _catching_distance := 1.4

var _chase_timer := 0.0
var _update_path_timer := 0.0


func enter(previous_state_name: String, data := {}) -> void:
	_chase_timer = chase_max_time


func update(delta: float) -> void:
	_update_path_timer -= delta
	_chase_timer -= delta
	if _chase_timer <= 0.0:
		requested_transition_to_other_state.emit("Searching", {"player_last_seen_position":_enemy.player.global_position})


func physics_update(_delta: float) -> void:
	if _update_path_timer <= 0.0:
		_update_path_timer = update_path_delay
		_enemy.travel_to_position(_enemy.player.global_position, _chasing_speed, true)
	
	if not _enemy.is_line_of_sight_broken():
		_chase_timer = chase_max_time
	
	if _enemy.global_position.distance_to(_enemy.player.global_position) <= _catching_distance:
		_enemy.reached_player.emit()
