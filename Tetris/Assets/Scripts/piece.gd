class_name Piece extends Node

const i_block = [Vector2i( - 1, 0), Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0)]
const l_block = [Vector2i( - 1, 0), Vector2i( - 1, 1), Vector2i(0, 0), Vector2i(1, 0)]
const j_block = [Vector2i( - 1, 0), Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1)]
const t_block = [Vector2i( - 1, 0), Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 0)]
const s_block = [Vector2i( - 1, 1), Vector2i(0, 1), Vector2i(0, 0), Vector2i(1, 0)]
const z_block = [Vector2i( - 1, 0), Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1)]
const o_block = [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 0), Vector2i(1, 1)]

var blocks = [i_block, l_block, j_block, t_block, s_block, z_block, o_block]
var bag = blocks.duplicate()
var colors_base = [Vector2i(1, 1), Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 2), Vector2i(0, 3), Vector2i(0, 2), Vector2i(1, 3)]
var colors = colors_base.duplicate()

var current_cells = []
var old_cells = []
var test_cells = []
var rotation_cells = []
var piecetype_cells = []
var current_position: Vector2i
var current_color: Vector2i
var test_position: Vector2i
var spawn_position = Vector2i(35, 9)
var preview_spawn_position = Vector2i(48, 10)

func set_rand_piece():
	var rand_num = randi() % bag.size()

	piecetype_cells = bag[rand_num]
	current_color = colors[rand_num]


	bag.remove_at(rand_num)
	colors.remove_at(rand_num)

	if bag.size() == 0:
		bag = blocks.duplicate()

	if colors.size() == 0:
		colors = colors_base.duplicate()

	current_cells = piecetype_cells
	rotation_cells = piecetype_cells

func rotate_piece(dir: int): # dir is used to decided which direction to rotate and I'm just using 0 and 1 to decide
	var new_x
	var new_y
	var new_rotation_cells = []
	
	for i in rotation_cells.size():
		if dir == 0:
			new_x = rotation_cells[i].y * -1
			new_y = rotation_cells[i].x
			new_rotation_cells.append(Vector2i(new_x, new_y))

		elif dir == 1:
			new_x = rotation_cells[i].y
			new_y = rotation_cells[i].x * -1
			new_rotation_cells.append(Vector2i(new_x, new_y))
	
	rotation_cells = new_rotation_cells

	for i in current_cells.size():
		current_cells[i] = current_position + rotation_cells[i]
		
	wall_kick(current_cells)


func wall_kick(cells: Array):
	var kick_amount = 0
	
	for i in cells.size():
		if cells[i].x < 29 || cells[i].x > 39 || cells[i].y < 9 || cells[i].y > 30:
			kick_amount += 1

	for i in cells.size():
		if cells[i].x < 29:
			cells[i].x += kick_amount 

		elif cells[i].x > 39:
			cells[i].x -= kick_amount 

		elif cells[i].y < 9:
			cells[i].y += kick_amount 

		elif cells[i].y > 30:
			cells[i].y -= kick_amount 
