extends Control

@onready var item_grid: GridContainer = $VBoxContainer/GridContainer

@export var item_slot: PackedScene
@export var inventory: Inventory

func _ready() -> void:
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("open_inventory"):
		if !is_visible():
			update_menu()
			show()
		else:
			for slot in item_grid.get_children():
					slot.queue_free()
			hide()

func update_menu() -> void:
	for item in inventory.get_items():
		var slot: InventorySlot = item_slot.instantiate()
		item_grid.add_child(slot)
		slot.item = item
		slot.button.icon = item.icon
		slot.get_node("CenterContainer/Button").connect("pressed", _on_slot_button_pressed.bind(slot.item))
		
func _on_slot_button_pressed(item: Item) -> void:
	inventory.spawn_item.emit(item)
	inventory.remove_item(item)