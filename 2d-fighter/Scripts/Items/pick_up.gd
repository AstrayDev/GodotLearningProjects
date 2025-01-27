class_name PickUp extends Node2D

@onready var area = $Area2D
@onready var sprite = $Sprite2D

@export var item: Item

func _ready() -> void:
	if !area.is_connected("body_entered", _on_pick_up_body_entered):
		area.connect("body_entered", _on_pick_up_body_entered)

func _on_pick_up_body_entered(body: Node2D) -> void:
	if body.has_method("on_item_picked_up"):
		body.on_item_picked_up(item)
		queue_free()