extends CanvasLayer

@onready var score_node = $"Control/score"
@onready var gameover = $"Control/game_over"

var score = Stats.current_score


func _ready():
	gameover.hide()

	Signalbus.piece_stacked.connect(_on_piece_stacked)
	Signalbus.game_over.connect(_on_game_over)


func _on_piece_stacked():
	score_node.text = "Score: %d" % Stats.current_score

func _on_game_over():
	gameover.show()
	get_tree().paused = true
