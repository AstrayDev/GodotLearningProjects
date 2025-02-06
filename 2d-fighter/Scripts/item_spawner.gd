class_name ItemSpawner extends Node2D

@onready var player: Player = owner as Player

func _ready() -> void:
	pass

func spawn(item_base: Item, item_path: String, spawn_position: Vector2, caller: Node) -> SpawnedItem:
	var item: SpawnedItem
	if FileAccess.file_exists(item_path):
		item = load(item_path).instantiate()
	else:
		print("Using recursive file search. Please check for correct file path in %s for better performance" % caller.get_scene_file_path())
		item = load(FileSearch.search_for_file("res://Scenes", "spawned_item.tscn")).instantiate()
		
	item.position = spawn_position
	item.item_name = item_base.name
	item.get_node("Sprite2D").texture = item_base.icon
	item.instance_script = item_base.instance_script
	return item
