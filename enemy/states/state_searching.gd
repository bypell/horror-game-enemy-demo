extends EnemyState

@export var search_time := 10.0
@export var _searching_speed := 6.0
@export var _search_radius := 10.0

var _search_timer := 0.0
var _player_last_seen_position: Vector3


func enter(previous_state_name: String, data := {}) -> void:
	if data["player_last_seen_position"]:
		_player_last_seen_position = data["player_last_seen_position"]
	else:
		printerr("State 'Searching' was not given the player's last seen position through the data dictionary.")
		
	_search_timer = search_time
	_go_to_position_around_player_last_seen_position()


func update(delta: float) -> void:
	_search_timer -= delta
	if _search_timer <= 0.0:
		requested_transition_to_other_state.emit("Roaming", {"do_not_reset_path": true})


func physics_update(_delta: float) -> void:
	if _enemy.navigation_agent.is_navigation_finished():
		_go_to_position_around_player_last_seen_position()
	
	if not _enemy.is_line_of_sight_broken():
		requested_transition_to_other_state.emit("Chasing")


func _go_to_position_around_player_last_seen_position() -> void:
	var random_position := _player_last_seen_position + _get_random_position_inside_circle(_search_radius, _player_last_seen_position.y)
	_enemy.travel_to_position(random_position, _searching_speed, true)


func _get_random_position_inside_circle(radius: float, height: float) -> Vector3:
	var theta: float = randf() * 2 * PI
	return Vector3(cos(theta), height, sin(theta)) * sqrt(randf()) * radius
