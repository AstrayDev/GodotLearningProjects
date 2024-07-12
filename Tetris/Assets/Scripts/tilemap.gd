extends TileMap

@onready var piece = Piece.new()

func _ready():
	spawn_piece()

func _process(_delta):
	if Input.is_action_pressed("move_down"):
		move(Vector2(0, 1))

	if Input.is_action_just_pressed("move_right"):
		move(Vector2(1, 0))

	if Input.is_action_just_pressed("move_left"):
		move(Vector2(-1, 0))

func spawn_piece():
	piece.set_rand_piece()
	piece.old_cells = piece.current_cells

	for pos in piece.current_cells:
		set_cell(0, pos, 0, piece.current_color)

func move(dir: Vector2):
			for pos in piece.current_cells:
				set_cell(0, pos + dir, 0, piece.current_color)