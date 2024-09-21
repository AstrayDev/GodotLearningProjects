extends CanvasLayer

@onready var score_node = $"Control/score"
@onready var gameover = $"Control/game_over_menu"

var score = Stats.current_score


func _ready():
	for node in gameover.get_children():
		node.hide()

	Signalbus.piece_stacked.connect(_on_piece_stacked)
	Signalbus.game_over.connect(_on_game_over)


func _on_piece_stacked():
	score_node.text = "Score: %d" % Stats.current_score

func _on_game_over():
	for node in gameover.get_children():
		node.show()
	Stats.reset()
	get_tree().paused = true

func _on_restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/title_screen.tscn")
	get_tree().paused = false
