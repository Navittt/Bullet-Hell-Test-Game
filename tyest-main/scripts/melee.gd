extends Area2D

var can_attack = false
#const PLAYER = preload("res://scenes/player.tscn")
#var player_instance = PLAYER.instance()
func _ready() -> void:
	#add_child(player_instance)
	#player_instance.is_attackingg.connect(_on_player_attacking)
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if can_attack == true:
		body.health -= 2
		print("worked")
