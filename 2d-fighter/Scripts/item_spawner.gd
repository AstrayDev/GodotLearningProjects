class_name ItemSpawner extends Node2D

@onready var player: Player = owner as Player

func _ready() -> void:
	pass

func spawn(item_base: Item, item_path: String, spawn_position: Vector2) -> SpawnedItem:
	var item: SpawnedItem = load(item_path).instantiate()
	item.position = spawn_position
	item.item_name = item_base.name
#	item.sprite.texture = item_base.icon
	item.get_node("Sprite2D").texture = item_base.icon
	return item
