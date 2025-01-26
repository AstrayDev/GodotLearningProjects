class_name Player extends Character_Base

@onready var state_machine: StateMachine = $StateMachine
@onready var state_text: Label = $StateText
@onready var attack_hitbox: Area2D = $AttackBox
@onready var direction: Vector2

@export var inventory: Inventory

# Used for the player state class to wait on to make sure eveerthing is loaded
# DON'T DELETE
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	state_text.text = state_machine.state.name

func on_item_picked_up(item: Item) -> void:
	inventory.add_item(item)
	print("I picked up a " + item.name)

func _on_health_depleted() -> void:
	hide()
	process_mode = PROCESS_MODE_DISABLED
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
