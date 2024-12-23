extends EnemyState

@export var _roaming_speed := 2.0

var _map_synchronized := false
var _target_position: Vector3
var _nav_map: RID


func _ready() -> void:
	await get_tree().physics_frame
	await get_tree().physics_frame
	_map_synchronized = true
	_nav_map = _enemy.get_world_3d().get_navigation_map()


func enter(previous_state_name: String, data := {}) -> void:
	if not _map_synchronized:
		return
	
	if data.has("do_not_reset_path") and data["do_not_reset_path"]:
		_enemy.travel_to_position(_enemy.navigation_agent.target_position, _roaming_speed)
		return
	
	_travel_to_random_position()


func physics_update(_delta: float) -> void:
	if not _map_synchronized:
		return
	
	if _enemy.navigation_agent.is_navigation_finished():
		_travel_to_random_position()
	
	if _enemy.is_player_in_view():
		requested_transition_to_other_state.emit("Chasing")


func _travel_to_random_position() -> void:
	var rand_pos := NavigationServer3D.map_get_random_point(_nav_map, 1, true)
	_enemy.travel_to_position(rand_pos, _roaming_speed)
