class_name Enemy extends Character_Base

signal player_detected(player_position: Vector2)

@onready var player: Player = get_tree().get_first_node_in_group("Player")

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_attack_box_entered(body: Node2D) -> void:
	print(body.name)

	if body.health_manager:
		body.health_manager.health -= 1
	else:
		print("No health manager found")

func _on_detection_box_body_entered(body:Node2D) -> void:
	if body == player:
		player_detected.emit(player.position)
		
