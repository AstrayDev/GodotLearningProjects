extends Enemy_State

func enter() -> void:
	enemy.animation.play("attack")
	enemy.attack_box.rotation = enemy.get_angle_to(enemy.player.position)
	enemy.attack_box.show()
	enemy.attack_box.monitoring = true

func action(_delta: float) -> void:
	pass

func exit() -> void:
	enemy.animation.stop()
		

func _on_animated_sprite_2d_animation_finished() -> void:
	enemy.animation.stop()
	enemy.attack_box.hide()
	enemy.attack_box.monitoring = false
	finished.emit("Chase")
