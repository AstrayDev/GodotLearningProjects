extends Control

func _ready():
	visible = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Assets/Scenes/main_menu.tscn")

func _on_button_down():
	get_tree().reload_current_scene()
	get_tree().paused = false
	pass

func _on_scores_game_over():
	get_tree().paused = true
	visible = true;