extends CharacterBody2D

const MOVE_SPEED = 500
const ACCEL_SPEED = MOVE_SPEED * 6
const SCREEN_BORDER_OFFSET = 50

@onready var screen_size := get_viewport_rect().size
@onready var ball = $"../Ball"

func _ready():
	var offset = 60
	var start_pos := Vector2(offset, screen_size.y / 2)
	position = start_pos
	pass

func _process(_delta: float):
	position.y = ball.position.y
	position.y = clamp(position.y, SCREEN_BORDER_OFFSET, screen_size.y - SCREEN_BORDER_OFFSET)

	move_and_collide(velocity * _delta)
	pass
