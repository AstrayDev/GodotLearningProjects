class_name Enemy_State extends State

var enemy: Enemy

func _ready() -> void:
	await owner._ready()
	enemy = owner as Enemy
	assert(Enemy != null, "Enemy is null")