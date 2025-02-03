class_name HitComponent extends CollisionShape2D

@onready var health_manager: HealthManager = get_parent().get_node("HealthManager")

func hit() -> void:
	health_manager.health -= 1
	
	if health_manager.health <= 0:
		health_manager.health_depleted.emit()
