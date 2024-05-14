extends Node2D

@onready var screen_size = get_viewport_rect().size
@onready var ball = $"../Ball"
@onready var player_score = $Player_Score
@onready var enemy_score = $Enemy_Score

var p_score := 0
var e_score := 0

func _ready():
	player_score.text = "0"
	enemy_score.text = "0"

func _process(_delta):
	if ball.position.x > screen_size.x:
		e_score += 1
		enemy_score.text = "%d" % e_score

		ball.Reset_Position()
		
	elif ball.position.x < 0:
		p_score += 1
		player_score.text = "%d" % p_score

		ball.Reset_Position()
