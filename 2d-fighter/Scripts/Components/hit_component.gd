class_name HitComponent extends CollisionShape2D

@onready var health_component: HealthComponent = get_parent().get_node("HealthComponent")

func hit() -> void:
	health_component.health -= owner.attack
	
	if health_component.health <= 0:
		health_component.health_depleted.emit()
