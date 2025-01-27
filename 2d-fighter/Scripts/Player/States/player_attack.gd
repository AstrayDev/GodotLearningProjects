extends PlayerState

func enter() -> void:
	player.animation.play("attack")
	player.attack_hitbox.monitoring = true
	player.attack_hitbox.show()
	
func _physics_process(_delta: float) -> void:
	pass

func exit() -> void:
	pass
	
func _on_animated_sprite_2d_animation_finished() -> void:
	print("Attack animation finished")
	player.attack_hitbox.monitoring = false
	player.attack_hitbox.hide()
	finished.emit("Idle")


func _on_attack_box_body_entered(body: Node2D) -> void:
	var anim: AnimatedSprite2D = body.get_node_or_null("AnimatedSprite2D")
	var health_manager = body.get_node_or_null("HealthManager")
	
	if health_manager:
		print(body.name + "Hit")
		health_manager.health -= 1
		print(health_manager.health)
	else:
		print(body.name + "Null")
		
	if anim:
		anim.play()
		anim.play_backwards()
