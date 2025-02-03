extends Enemy_State

func enter() -> void:
	enemy.animation.play("idle")
	enemy.player_detected.connect(_on_player_detected)

func action(_delta: float) -> void:
	pass

func exit() -> void:
	print("Exiting Idle state")
	enemy.animation.stop()
	
func _on_player_detected(player_position: Vector2) -> void:
	finished.emit("Chase")
	enemy.player_detected.disconnect(_on_player_detected)
