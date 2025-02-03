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
	var hit_component: HitComponent = body.get_node_or_null("HitComponent")
	
	if hit_component:
		hit_component.hit()
		
	if anim:
		anim.play()
		anim.play_backwards()
