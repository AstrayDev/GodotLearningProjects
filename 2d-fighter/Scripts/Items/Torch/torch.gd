extends SpawnedItem

func action() -> void:
	print("Torch action")
	var collision = CollisionShape2D.new()
	collision.shape = CircleShape2D.new()
	collision.shape.radius = 10
	add_child(collision)
	collision.show()
