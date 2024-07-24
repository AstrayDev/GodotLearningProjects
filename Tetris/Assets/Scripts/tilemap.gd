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
		for pos in piece.old_cells:
			erase_cell(0, pos)
			
		piece.rotate_left()

		for i in piece.current_cells:
			set_cell(0, i, 0, piece.current_color)

	print(piece.current_cells)

func spawn_piece():
	var spawn_pos = []
	var spawn_offset

	for pos in piece.current_cells:
		spawn_offset = pos + piece.spawn_position
		set_cell(0, spawn_offset, 0, piece.current_color)
		spawn_pos.append(spawn_offset)

	piece.current_cells = spawn_pos

func move(dir: Vector2i):
	var new_cells = []
	piece.old_cells = piece.current_cells # assign last known valid position

	for pos in piece.old_cells:
		erase_cell(0, pos)

	for pos in piece.current_cells:
		piece.test_position = pos + dir
		if is_valid_move():
			if should_stack_piece():
				return
			else:
				piece.current_position = pos + dir
				set_cell(0, piece.current_position, 0, piece.current_color)
				new_cells.append(piece.current_position)

		else: # if move isn't valid return to previous position
			piece.current_cells = piece.old_cells
			for old_pos in piece.current_cells:
				set_cell(0, old_pos, 0, piece.current_color)
			return
			
	piece.current_cells = new_cells

func is_valid_move() -> bool:
	var id = get_cell_alternative_tile(0, piece.test_position)
	if id == 3:
		return false
	return true

func should_stack_piece() -> bool:
	var id = get_cell_source_id(0, piece.test_position)

	if id == 0:
		for pos in piece.current_cells:
			set_cell(0, pos, 0, piece.current_color)
		piece.free()
		piece = Piece.new()
		piece.set_rand_piece()
		spawn_piece()
		return true
	return false
