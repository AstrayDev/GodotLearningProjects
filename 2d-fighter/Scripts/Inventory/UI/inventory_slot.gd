class_name InventorySlot extends Control

@onready var button: Button = $CenterContainer/Button
@onready var item: Item

# TODO: GET RID OF THE GET_PARENT() CALLS IT'S UGLY

func _on_draw() -> void:
	print(item.name + " in inventory")

func _on_button_pressed() -> void:
	print(item.get_path() + " Selected")
	if item.instance_script != null:
		item.instance_script.action()
	else: 
		print("script is null")
	get_parent().get_parent().get_parent().inventory.spawn_item.emit(item)