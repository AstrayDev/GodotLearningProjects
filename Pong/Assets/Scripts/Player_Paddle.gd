extends CharacterBody2D

const MOVE_SPEED = 500
const ACCEL_SPEED = MOVE_SPEED * 6
const SCREEN_BORDER_OFFSET = 50

@onready var screen_size := get_viewport_rect().size

func _ready():
	var offest = 60
	var start_pos := Vector2(screen_size.x - offest, screen_size.y / 2)
	position = start_pos
	pass

func _process(_delta: float):
	var input_dir := Input.get_axis("move_up", "move_down") * MOVE_SPEED
	
	velocity.y = move_toward(velocity.y, input_dir, ACCEL_SPEED * _delta)
	position.y = clamp(position.y, SCREEN_BORDER_OFFSET, screen_size.y - SCREEN_BORDER_OFFSET)

	move_and_collide(velocity * _delta)
	pass
