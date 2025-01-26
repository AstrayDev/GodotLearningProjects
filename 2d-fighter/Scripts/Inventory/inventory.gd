class_name Inventory extends Resource

var items: Array[Item] = []

func add_item(item: Item) -> void:
	items.append(item)
	
func get_items() -> Array[Item]:
	return items