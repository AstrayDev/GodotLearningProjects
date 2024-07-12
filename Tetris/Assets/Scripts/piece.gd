extends Node

class_name Piece

const i_block = [Vector2(0, 0), Vector2(1, 0), Vector2(2, 0), Vector2(3, 0)]
const l_block = [Vector2(0, 0), Vector2(0, 1), Vector2(1, 0), Vector2(2, 0)]
const j_block = [Vector2(0, 0), Vector2(1, 0), Vector2(2, 0), Vector2(2, 1)]
const t_block = [Vector2(0, 0), Vector2(1, 0), Vector2(1, 1), Vector2(2, 0)]
const s_block = [Vector2(0, 1), Vector2(1, 1), Vector2(1, 0), Vector2(2, 0)]
const z_block = [Vector2(0, 0), Vector2(1, 0), Vector2(1, 1), Vector2(2, 1)]
const o_block = [Vector2(0, 0), Vector2(0, 1), Vector2(1, 0), Vector2(1, 1)]

var current_cells = []
var old_cells = []
var current_color

func set_rand_piece():
	var rand_num = randi() % 7

	match rand_num:
		0:
			current_cells += i_block
			current_color = Vector2(1, 1)
		1:
			current_cells += l_block
			current_color = Vector2(0, 0)
		2:
			current_cells += j_block
			current_color = Vector2(0, 1)
		3:
			current_cells += t_block
			current_color = Vector2(1, 2)
		4:
			current_cells += s_block
			current_color = Vector2(0, 3)
		5:
			current_cells += z_block
			current_color = Vector2(0, 2)
		6:
			current_cells += o_block
			current_color = Vector2(1, 3)

func _ready():
	pass