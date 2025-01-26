class_name InventorySlot extends Control

@onready var button: Button = $CenterContainer/Button
var item: Item

func _on_draw() -> void:
	print("slot drawn")
	
func _on_button_pressed() -> void:
	print(item.name + " Selected")
#	Allows access to item script for item specific action
	var script = item.instance_script.new()
	if script.has_method("action"):
		script.action.call()
		script.free()
	else:
		print("script is missing action method")