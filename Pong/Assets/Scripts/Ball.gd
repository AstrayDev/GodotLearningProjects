extends CharacterBody2D

const SCREEN_BORDER_OFFSET = 50
const MOVE_SPEED = 300

@onready var screen_size = get_viewport_rect().size

func _ready():
	position = Vector2(screen_size / 2)
	velocity = set_ball_dir()

func _physics_process(_delta: float):
		var collision: KinematicCollision2D = move_and_collide(velocity * _delta)

		if collision:
			var collider = collision.get_collider() as PhysicsBody2D

			if collider.is_in_group("Paddles"):
				velocity = velocity.bounce(collision.get_normal())

		move_and_collide(velocity * _delta)

func _on_vert_bounds_body_entered(body: Node2D):
	if body.is_in_group("Ball"):
		velocity = velocity.bounce(Vector2(0, -1))

func set_ball_dir() -> Vector2:
	var rand_dir = [Vector2(1, 1), Vector2(1, -1), Vector2(-1, 1), Vector2(-1, -1)]
	var index = randi_range(0, rand_dir.size() - 1)

	return rand_dir[index].normalized() * MOVE_SPEED

func Reset_Position():
	position = Vector2(screen_size / 2)

	velocity = set_ball_dir()