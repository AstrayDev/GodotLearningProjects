extends Node2D

@onready var screen_size = get_viewport_rect().size

func _ready():
	position = screen_size / 2