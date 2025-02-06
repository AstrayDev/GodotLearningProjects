class_name SpawnedItem extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

var item_name: String
var instance_script: GDScript

func _ready() -> void:
	instance_script.new().action()
