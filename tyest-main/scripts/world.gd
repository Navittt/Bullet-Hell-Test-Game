extends Node2D

@onready var enemy: CharacterBody2D = $enemy
@onready var world: Node2D = $"."

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if has_node("enemy"):
		pass
	else:
		pass
	
	
