extends CanvasItem

@onready var screen_size = get_viewport_rect().size

func _draw():
	var color := Color.WHITE
	var line_width = 6
	var dash_length = 10

	var line_start := Vector2(screen_size.x / 2, 0)
	var line_end := Vector2(screen_size.x / 2, screen_size.y)

	draw_dashed_line(line_start, line_end, color, line_width, dash_length)