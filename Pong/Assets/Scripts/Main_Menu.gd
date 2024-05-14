extends Button

func _ready():
	pass 


func _process(_delta: float):
	pass


func _on_button_down():
	get_tree().change_scene_to_file("res://Assets/Scenes/main.tscn")
