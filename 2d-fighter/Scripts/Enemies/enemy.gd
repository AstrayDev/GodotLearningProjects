class_name Enemy extends CharacterBase

signal player_detected(player_position: Vector2)

@export var speed: float
@export var attack: int

@onready var player: Player = get_tree().get_first_node_in_group("Player")

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_attack_box_entered(body: Node2D) -> void:
	if body.has_signal("damage_taken"):
		body.damage_taken.emit()
		print(body.stats.health)
	else:
		print("Target doesn't have a 'HitComponent'")

func _on_detection_box_body_entered(body:Node2D) -> void:
	if body == player:
		player_detected.emit(player.position)
		
		
func die() -> void:
	print(name + " has died")
	queue_free()	
