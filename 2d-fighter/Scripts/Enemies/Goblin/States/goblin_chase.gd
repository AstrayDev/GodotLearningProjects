extends Enemy_State

func enter() -> void:
	enemy.animation.play("run")
	print("Entering goblin Chase state")
	
func action(_delta: float) -> void:
	if enemy.velocity.x > 0:
		enemy.animation.flip_h = true
		
	elif enemy.velocity.x < 0:
		enemy.animation.flip_h = false

	enemy.direction = (enemy.player.position - enemy.position).normalized()
	enemy.velocity = enemy.direction * enemy.speed * _delta	
	enemy.move_and_collide(enemy.velocity)

func exit() -> void:
	print("Exiting Chase state")
	enemy.animation.stop()

func _on_attack_range_box_entered(body: Node2D) -> void:
	print("Player in attack range")
	finished.emit("Attack")
