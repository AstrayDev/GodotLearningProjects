extends TileMap

@onready var piece = Piece.new()
var left_bounds = Vector2i(29, 0)
var right_bounds = Vector2i(40, 0)
var tp

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

	if Input.is_action_just_pressed("ui_accept"):
		piece.rotate_piece()

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

	# deletes old cells
	for pos in piece.old_cells:
		erase_cell(0, pos)

	for pos in piece.current_cells:
		piece.test_cells.append(pos + dir) # test if the next move is valid before its rendered
		tp = pos + dir
		if is_valid_move():
			piece.current_position = pos + dir
			set_cell(0, piece.current_position, 0, piece.current_color)
			new_cells.append(piece.current_position)

		else: # if move isn't valid return to previous position
			piece.current_cells = piece.old_cells
			for old_pos in piece.current_cells:
				set_cell(0, old_pos, 0, piece.current_color)
			piece.test_cells = [] # empty test cells for next move
			return
			
	# cleanup for next move
	piece.current_cells = new_cells
	piece.test_cells = []

func is_valid_move() -> bool:
	var id = get_cell_source_id(0, tp)
	for pos in piece.test_cells:
		if pos < left_bounds or pos > right_bounds or id == 0:
			return false
	return true
