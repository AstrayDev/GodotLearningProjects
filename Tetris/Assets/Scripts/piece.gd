extends Node

class_name Piece

const i_block = [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0)]
const l_block = [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 0), Vector2i(2, 0)]
const j_block = [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(2, 1)]
const t_block = [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 0)]
const s_block = [Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 0), Vector2i(2, 0)]
const z_block = [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
const o_block = [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 0), Vector2i(1, 1)]

var current_cells = []
var old_cells = []
var test_cells = []
var current_position: Vector2i
var current_color: Vector2i
var spawn_position = Vector2i(34, 9)

func set_rand_piece():
	var rand_num = randi() % 7

	match rand_num:
		0:
			current_cells += i_block
			current_color = Vector2i(1, 1)
		1:
			current_cells += l_block
			current_color = Vector2i(0, 0)
		2:
			current_cells += j_block
			current_color = Vector2i(0, 1)
		3:
			current_cells += t_block
			current_color = Vector2i(1, 2)
		4:
			current_cells += s_block
			current_color = Vector2i(0, 3)
		5:
			current_cells += z_block
			current_color = Vector2i(0, 2)
		6:
			current_cells += o_block
			current_color = Vector2i(1, 3)

func rotate_piece():
	for i in current_cells.size():
		var new_x = current_cells[i].y * -1
		current_cells[i].y = current_cells[i].x
		current_cells[i].x = new_x
