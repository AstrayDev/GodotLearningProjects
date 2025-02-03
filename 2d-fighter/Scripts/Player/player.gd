class_name Player extends CharacterBase

signal damage_taken

@export var inventory: Inventory
@export var stats: PlayerStats

@onready var item_spawner: ItemSpawner = $ItemSpawner
@onready var state_machine: StateMachine = $StateMachine
@onready var state_text: Label = $StateText
@onready var attack_hitbox: Area2D = $AttackBox
@onready var direction: Vector2

func _ready() -> void:
	if !damage_taken.is_connected(_on_damage_taken):
		damage_taken.connect(_on_damage_taken)
	if !inventory.spawn_item.is_connected(_on_spawn_item):
		inventory.spawn_item.connect(_on_spawn_item)
		
	stats.health = stats.max_health	

func _process(_delta: float) -> void:
	state_text.text = state_machine.state.name
	stats.position = position

func on_item_picked_up(item: Item) -> void:
	inventory.add_item(item)
	print("I picked up a " + item.name)

func _on_spawn_item(item_base: Item) -> void:	
	var item: SpawnedItem = item_spawner.spawn(item_base, "res://Scenes/spawned_item.tscn", position)
	get_parent().add_child(item)
	
func _on_damage_taken() -> void:
	stats.health -= 1
	if stats.health <= 0:
		die()

func die() -> void:
	hide()
	process_mode = PROCESS_MODE_DISABLED
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()