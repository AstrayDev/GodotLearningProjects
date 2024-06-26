extends CharacterBody2D
 
const MOVE_SPEED := 80

func _ready():
	pass

func _process(_delta: float):
	if (Input.is_action_just_pressed("move_right")):
		move(Vector2(1, 0))

	if (Input.is_action_just_pressed("move_left")):
		move(Vector2( - 1, 0))

	if (Input.is_action_just_pressed("move_down")):
		move(Vector2(0, 1))

	if (Input.is_action_just_pressed("ui_accept")):
		var r = deg_to_rad(90)
		rotate(r)

func move(dir: Vector2) -> void:
	move_and_collide(dir * MOVE_SPEED)