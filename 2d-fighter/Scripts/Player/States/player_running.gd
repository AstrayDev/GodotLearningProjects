extends Player_State

func enter() -> void:
	player.animation.play("run")
	
func action(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	
	player.velocity = input_dir * player.speed * delta
	player.move_and_collide(player.velocity)
	
	if input_dir.x > 0:
		player.animation.flip_h = true
		player.direction = Vector2.RIGHT
		
	if input_dir.x < 0:
		player.animation.flip_h = false
		player.direction = Vector2.LEFT
	
	if input_dir == Vector2.ZERO:
		finished.emit("Idle")
		
	if Input.is_action_just_pressed("attack"):
		finished.emit("Attack")
		
func exit() -> void:
	player.animation.stop()