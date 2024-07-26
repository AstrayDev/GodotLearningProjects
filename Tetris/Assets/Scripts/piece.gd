extends Node

class_name Piece

const i_block = [Vector2i( - 1, 0), Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0)]
const l_block = [Vector2i( - 1, 0), Vector2i( - 1, 1), Vector2i(0, 0), Vector2i(1, 0)]
const j_block = [Vector2i( - 1, 0), Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1)]
const t_block = [Vector2i( - 1, 0), Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 0)]
const s_block = [Vector2i( - 1, 1), Vector2i(0, 1), Vector2i(0, 0), Vector2i(1, 0)]
const z_block = [Vector2i( - 1, 0), Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1)]
const o_block = [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 0), Vector2i(1, 1)]

var current_cells = []
var old_cells = []
var test_cells = []
var rotation_cells = []
var blocktype_cells = []
var current_position: Vector2i
var current_color: Vector2i
var test_position: Vector2i
var spawn_position = Vector2i(35, 9)

func set_rand_piece():
	var rand_num = randi() % 7

	match rand_num:
		0:
			blocktype_cells += i_block
			current_color = Vector2i(1, 1)
		1:
			blocktype_cells += l_block
			current_color = Vector2i(0, 0)
		2:
			blocktype_cells += j_block
			current_color = Vector2i(0, 1)
		3:
			blocktype_cells += t_block
			current_color = Vector2i(1, 2)
		4:
			blocktype_cells += s_block
			current_color = Vector2i(0, 3)
		5:
			blocktype_cells += z_block
			current_color = Vector2i(0, 2)
		6:
			blocktype_cells += o_block
			current_color = Vector2i(1, 3)

	current_cells = blocktype_cells
	rotation_cells = blocktype_cells

func rotate_piece(dir: int): # dir is used to decided which direction to rotate and I'm just using 0 and 1 to decide
	var new_x
	var new_y
	var new_rotation_cells = []

	for i in rotation_cells.size():
		if dir == 0:
			new_x = rotation_cells[i].y * - 1
			new_y = rotation_cells[i].x
			new_rotation_cells.append(Vector2i(new_x, new_y))

		elif dir == 1:
			new_x = rotation_cells[i].y
			new_y = rotation_cells[i].x * -1
			new_rotation_cells.append(Vector2i(new_x, new_y))
	
	rotation_cells = new_rotation_cells
	for i in current_cells.size():
		current_cells[i] = current_position + rotation_cells[i]
