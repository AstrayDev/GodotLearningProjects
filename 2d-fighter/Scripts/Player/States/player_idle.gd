extends Player_State

func enter() -> void:
	player.animation.play("idle")	
	
func action(_delta: float) -> void:
	if Input.get_vector("move_left", "move_up", "move_down", "move_right") != Vector2.ZERO:
		finished.emit("Running")
		
	if Input.is_action_just_pressed("attack"):
		finished.emit("Attack")

func exit() -> void:
	player.animation.stop()
