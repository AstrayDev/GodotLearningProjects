class_name State extends Node
# This is a base class for all states
# Also allows for quick access to the player for autocompletion

signal finished(next_state_path: String)
	
func _physics_process(_delta: float) -> void:
	pass
	
func action(_delta: float) -> void:
	pass
func enter() -> void:
	pass
	
func exit() -> void:
	pass