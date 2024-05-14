extends CharacterBody2D

const SCREEN_BORDER_OFFSET = 50
const MOVE_SPEED = 250
const MIN_RAND_Y_DIR = -30
const MAX_RAND_Y_DIR = -100

@onready var screen_size = get_viewport_rect().size

func _ready():
	position = Vector2(screen_size / 2)
	
	var rand_dir := Vector2(randi_range( - screen_size.x, screen_size.x), randi_range(MIN_RAND_Y_DIR, MAX_RAND_Y_DIR)).normalized()
	velocity = rand_dir * MOVE_SPEED

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

func Reset_Position():
	position = Vector2(screen_size / 2)

	var rand_dir := Vector2(randi_range( - screen_size.x, screen_size.x), randi_range(MIN_RAND_Y_DIR, MAX_RAND_Y_DIR)).normalized()
	velocity = rand_dir * MOVE_SPEED