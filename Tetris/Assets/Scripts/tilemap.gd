extends TileMap

var piece = Piece.new()

func _ready():
	piece.set_rand_piece()
	spawn_piece()

func _process(_delta):
	if Input.is_action_pressed("move_down"):
		move(Vector2i.DOWN)

	if Input.is_action_just_pressed("move_right"):
		move(Vector2i.RIGHT)

	if Input.is_action_just_pressed("move_left"):
		move(Vector2i.LEFT)

	if Input.is_action_just_pressed("turn_left"):
		piece.old_cells = piece.current_cells
		for i in piece.old_cells:
			erase_cell(0, i)
			
		piece.rotate_piece(1)

		for i in piece.current_cells:
			set_cell(0, i, 0, piece.current_color)

	if Input.is_action_just_pressed("turn_right"):
		piece.old_cells = piece.current_cells
		for pos in piece.old_cells:
			erase_cell(0, pos)
			
		piece.rotate_piece(0)

		for i in piece.current_cells:
			set_cell(0, i, 0, piece.current_color)

func spawn_piece():
	var spawn_pos = []
	var spawn_offset

	for i in piece.current_cells:
		spawn_offset = i + piece.spawn_position
		set_cell(0, spawn_offset, 0, piece.current_color)
		spawn_pos.append(spawn_offset)

	piece.current_cells = spawn_pos

func move(dir: Vector2i):
	var new_cells = []
	piece.old_cells = piece.current_cells # assign last known valid position

	for pos in piece.current_cells:
		piece.test_cells.append(pos + dir)

	for i in piece.old_cells:
		erase_cell(0, i)

	if is_valid_move():
		if should_stack_piece():
			for j in piece.current_cells:
				set_cell(0, j, 0, piece.current_color)
			reset_piece()
		else:
			for i in piece.test_cells:
				piece.current_position = i
				set_cell(0, piece.current_position, 0, piece.current_color)
				new_cells.append(piece.current_position)
			piece.current_cells = new_cells

	else: # if move isn't valid return to previous position
		for old_pos in piece.old_cells:
			set_cell(0, old_pos, 0, piece.current_color)

	piece.test_cells.clear() # reset test cells for next move

func is_valid_move() -> bool:
	var id: int
	for i in piece.test_cells:
		id = get_cell_alternative_tile(0, i)
		if id == 3 || id == 0 && Input.is_action_just_pressed("move_right") || id == 0 && Input.is_action_just_pressed("move_left"):
			return false
	return true

func should_stack_piece() -> bool:
	var id: int
	for i in piece.test_cells:
		id = get_cell_alternative_tile(0, i)
		if Input.is_action_pressed("move_down") &&  id == 0 || id == 5:
			return true
	return false

func reset_piece():
	check_rows()
	piece.free()
	piece = Piece.new()
	piece.set_rand_piece()
	spawn_piece()

func check_rows():	
	var rows_to_erase = []
	for y in range(30, 10, -1): # border height
		var row = []
		var row_full = true
		for x in range(29, 40): # border width
			row.append(Vector2i(x, y))
		for i in row:
			if get_cell_source_id(0, i) == -1:
				row_full = false
				break # exit loop if a cell is empty
		if row_full:
			rows_to_erase.append(y)
	
	if rows_to_erase.size() > 0:
		erase_rows(rows_to_erase)
		push_down_rows(rows_to_erase)

func erase_rows(rows: Array):
	for row in rows:
		for x in range(29, 40):
			var cell_pos = Vector2i(x, row)
			erase_cell(0, cell_pos)

func push_down_rows(rows: Array):
	var amount_to_push = rows.size()
	for row in rows:
		for y in range(row - 1, 9, -1): # Start from the row above the erased row
			for x in range(29, 40):
				var cell_pos = Vector2i(x, y)
				var below_pos = Vector2i(x, y + amount_to_push)
				var color = get_cell_atlas_coords(0, cell_pos)
				var id = get_cell_source_id(0, below_pos)
				if id == -1:
					erase_cell(0, cell_pos)
					set_cell(0, below_pos, 0, color)
