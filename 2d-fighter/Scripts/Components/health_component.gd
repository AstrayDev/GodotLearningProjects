class_name HealthComponent extends Node

signal health_depleted

@export var max_health: int = 2
var health: int

func _ready() -> void:
	health_depleted.connect(_on_health_depleted)
	health = max_health

func _on_health_depleted() -> void:
#	if owner is CharacterBase:
#		owner.die()
#	else:
	get_parent().queue_free()