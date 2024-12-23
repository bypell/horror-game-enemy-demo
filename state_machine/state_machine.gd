class_name StateMachine extends Node

@export var initial_state: State = null

@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
).call()


func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		state_node.requested_transition_to_other_state.connect(_transition_to_next_state)

	await owner.ready
	state.enter("")


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func _transition_to_next_state(target_state_name: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		printerr(owner.name + ": Trying to transition to state " + target_state_name + " but it does not exist.")
		return

	var previous_state_name := state.name
	state.exit()
	state = get_node(target_state_name)
	state.enter(previous_state_name, data)
