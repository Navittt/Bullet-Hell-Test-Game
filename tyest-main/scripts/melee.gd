extends Area2D

var can_attack = false
const PLAYER = preload("res://scenes/player.tscn")

func _ready() -> void:
	var player_instance = PLAYER.instance()
	add_child(player_instance)
	player_instance.connect("is_attackingg", self, "_on_player_attacking", [], CONNECT_ONE_SHOT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_attacking():
	print("Player is attacking!")

func _on_body_entered(body: Node2D) -> void:
	if can_attack:
		body.health -= 1.5
