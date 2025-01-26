extends Control

@onready var item_grid: GridContainer = $VBoxContainer/GridContainer

@export var item_slot: PackedScene
@export var inventory: Inventory

func _ready() -> void:
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("open_inventory"):
		if !is_visible():
			for item in inventory.get_items():
				if inventory.get_items().size() > item_grid.get_child_count():
					var slot: InventorySlot = item_slot.instantiate()
					item_grid.add_child(slot)
					slot.item = item
					slot.button.icon = item.icon
			show()
		else:
			hide()
