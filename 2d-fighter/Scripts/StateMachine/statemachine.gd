class_name StateMachine extends Node

@onready var state: State

# Get each state as a child and connect the finished signal. The first is idle then enter
func _ready() -> void:
	for child in get_children():
		child.finished.connect(_change_state)
	state = get_child(0)
	state.enter()
	
func _change_state(new_state_path: String) -> void:
	var new_state: Node = get_node(new_state_path)
	if new_state != null && new_state != state:
		state.exit()
		state = new_state
		state.enter()
		
	else:
		print("State is null or already in use")
		
# Call the action function of the current state which defines behavior
func _physics_process(delta: float) -> void:
	state.action(delta)
