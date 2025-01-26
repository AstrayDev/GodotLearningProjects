class_name Player_State extends State

var player: Player

func _ready() -> void:
	await owner._ready()
	player = owner as Player
	assert(player != null, "Player is null")
