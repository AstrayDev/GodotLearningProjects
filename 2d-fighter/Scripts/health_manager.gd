class_name HealthManager extends Node

signal health_depleted

func _ready() -> void:
	health_depleted.connect(_on_health_depleted)

func _on_health_depleted() -> void:
	if owner != get_tree().get_first_node_in_group("Player"):
		get_parent().queue_free()