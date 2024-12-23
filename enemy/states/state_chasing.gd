extends EnemyState

const CHASE_MAX_TIME := 8.0

@export var _chasing_speed := 6.0
@export var _catching_distance := 1.4

var _chase_timer := 0.0


func enter(previous_state_name: String, data := {}) -> void:
	_chase_timer = CHASE_MAX_TIME


func update(delta: float) -> void:
	_chase_timer -= delta
	if _chase_timer < 0.0:
		requested_transition_to_other_state.emit("Roaming", {"do_not_reset_path":true})


func physics_update(_delta: float) -> void:
	_enemy.travel_to_position(_enemy.player.global_position, _chasing_speed, true)
	
	if not _enemy.is_line_of_sight_broken():
		_chase_timer = CHASE_MAX_TIME
	
	if _enemy.global_position.distance_to(_enemy.player.global_position) <= _catching_distance:
		_enemy.reached_player.emit()
