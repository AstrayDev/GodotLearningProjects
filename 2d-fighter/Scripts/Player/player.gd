class_name Player extends CharacterBase

@onready var state_machine: StateMachine = $StateMachine
@onready var state_text: Label = $StateText
@onready var attack_hitbox: Area2D = $AttackBox
@onready var direction: Vector2

@export var inventory: Inventory
@export var stats: PlayerStats

# Used for the player state class to wait on to make sure eveerthing is loaded
# DON'T DELETE
func _ready() -> void:
	if !damage_taken.is_connected(_on_damage_taken):
		damage_taken.connect(_on_damage_taken)
	
	stats.health = stats.max_health	

func _process(_delta: float) -> void:
	state_text.text = state_machine.state.name
	stats.position = position

func on_item_picked_up(item: Item) -> void:
	inventory.add_item(item)
	print("I picked up a " + item.name)

func _on_damage_taken() -> void:
	stats.health -= 1
	
	if stats.health <= 0:
		health_manager.health_depleted.emit()

func _on_health_depleted() -> void:
	hide()
	process_mode = PROCESS_MODE_DISABLED
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
