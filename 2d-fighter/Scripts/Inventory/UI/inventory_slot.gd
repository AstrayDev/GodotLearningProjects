class_name InventorySlot extends Control

@onready var button: Button = $CenterContainer/Button
@onready var item: Item

func _on_draw() -> void:
	print(item.name + " in inventory")

func _on_button_pressed() -> void:
	queue_free()