extends TileMap

@onready var piece_scene = preload("res://Assets/Scenes/piece.tscn")
var current_piece
var preview_piece

func _ready():
	var timer = get_parent().get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
	current_piece = spawn_piece(Vector2i(35, 10))
	preview_piece = spawn_piece(Vector2i(48, 10))

func _process(_delta):
	if Input.is_action_pressed("move_down"):
		move(Vector2i.DOWN)

	if Input.is_action_just_pressed("move_right"):
		move(Vector2i.RIGHT)

	if Input.is_action_just_pressed("move_left"):
		move(Vector2i.LEFT)

	if Input.is_action_just_pressed("turn_left"):
		current_piece.old_cells = current_piece.current_cells
		for i in current_piece.old_cells:
			erase_cell(0, i)
			
		current_piece.rotate_piece(1)

		for i in current_piece.current_cells:
			set_cell(0, i, 0, current_piece.current_color)

	if Input.is_action_just_pressed("turn_right"):
		current_piece.old_cells = current_piece.current_cells
		for pos in current_piece.old_cells:
			erase_cell(0, pos)
			
		current_piece.rotate_piece(0)

		for i in current_piece.current_cells:
			set_cell(0, i, 0, current_piece.current_color)

func spawn_piece(offset: Vector2i) -> Node2D:
	var piece: Node2D
	var spawn_pos = []
	var spawn_offset

	
	piece = piece_scene.instantiate()
	add_child(piece)
	piece.set_rand_piece()

	for i in piece.current_cells:
		spawn_offset = i + offset
		set_cell(0, spawn_offset, 0, piece.current_color)
		spawn_pos.append(spawn_offset)

	piece.current_cells = spawn_pos
	return piece

func swap_piece(new_piece: Node2D, offset: Vector2i):
	var spawn_pos = []

	for i in new_piece.piecetype_cells:
		spawn_pos.append(i + offset)

	new_piece.current_cells = spawn_pos

	return new_piece

func move(dir: Vector2i):
	var new_cells = []
	current_piece.old_cells = current_piece.current_cells # assign last known valid position

	for pos in current_piece.current_cells:
		current_piece.test_cells.append(pos + dir)

	for i in current_piece.old_cells:
		erase_cell(0, i)

	if is_valid_move():
		if should_stack_piece():
			for j in current_piece.current_cells:
				set_cell(0, j, 0, current_piece.current_color)
			reset_piece()
		else:
			for i in current_piece.test_cells:
				current_piece.current_position = i
				set_cell(0, current_piece.current_position, 0, current_piece.current_color)
				new_cells.append(current_piece.current_position)
			current_piece.current_cells = new_cells

	else: # if move isn't valid return to previous position
		for old_pos in current_piece.old_cells:
			set_cell(0, old_pos, 0, current_piece.current_color)

	current_piece.test_cells.clear() # reset test cells for next move

func _on_timer_timeout():
		move(Vector2i.DOWN)

func is_valid_move() -> bool:
	var id: int
	for i in current_piece.test_cells:
		id = get_cell_alternative_tile(0, i)
		if id == 3 || id == 0 && Input.is_action_just_pressed("move_right") || id == 0 && Input.is_action_just_pressed("move_left"):
			return false
	return true

func should_stack_piece() -> bool:
	var id: int
	for i in current_piece.test_cells:
		id = get_cell_alternative_tile(0, i)
		if id == 0 || id == 5:
			return true
	return false	

func reset_piece():
	check_rows()

	for i in preview_piece.current_cells:
		erase_cell(0, i)

	current_piece = swap_piece(preview_piece, current_piece.spawn_position)
	preview_piece = spawn_piece(preview_piece.preview_spawn_position)

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
		for y in range(row, 9, -1):
			for x in range(29, 40):
				var cell_pos = Vector2i(x, y)
				var below_pos = Vector2i(x, y + amount_to_push)
				var color = get_cell_atlas_coords(0, cell_pos)
				var id = get_cell_source_id(0, below_pos)
				if id == -1:
					erase_cell(0, cell_pos)
					set_cell(0, below_pos, 0, color)
