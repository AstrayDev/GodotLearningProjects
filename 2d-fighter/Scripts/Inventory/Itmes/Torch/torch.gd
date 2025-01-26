extends PickUp

var thing = load("res://Scripts/Inventory/Itmes/Torch/torch.tres")
# Needed for runtime for some annoying reason
var t = thing.duplicate()

func action() -> void:
	print(t.name + " activated")
