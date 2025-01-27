class_name Enemy extends CharacterBase

signal player_detected(player_position: Vector2)

@onready var player: Player = get_tree().get_first_node_in_group("Player")
@export var speed: float

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_attack_box_entered(body: Node2D) -> void:
	print(body.name)

	if body.has_signal("damage_taken"):
		body.damage_taken.emit()
	else:
		print("Target doesn't have a 'damage_taken' signal")

func _on_detection_box_body_entered(body:Node2D) -> void:
	if body == player:
		player_detected.emit(player.position)
		
