class_name HealthManager extends Node

signal health_depleted

@export var health: int

func _ready() -> void:
	health_depleted.connect(_on_health_depleted)

func _on_health_depleted() -> void:
	print("ded")
	if owner is CharacterBase:
		owner.die()
	else:
		get_parent().queue_free()