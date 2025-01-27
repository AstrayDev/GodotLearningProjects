extends Area2D

@onready var player: Player = owner
	
# For Rotation depending on the direction of the player
func _process(_delta: float) -> void:
	if player.direction == Vector2.RIGHT:
		rotation = 0
	else:
		rotation_degrees = 180
	pass