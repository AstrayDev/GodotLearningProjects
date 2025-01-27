extends PickUp

var _resource = load("res://Scripts/Items/Torch/torch.tres")
# Needed for runtime for some annoying reason
var resource = _resource.duplicate()

func action() -> void:
	print(resource.player_stats.position)