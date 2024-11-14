extends CharacterBody2D
var speed = 25
var chase = false
var motion = Vector2.ZERO
var health = 8

@onready var progress_bar: ProgressBar = $ProgressBar


func _ready():
	progress_bar.value = health
	

func _physics_process(delta):
	progress_bar.value = health
	if health <= 0:
		queue_free()
	
	var player = get_parent().get_node("player")
	
	if chase:
		position += (player.position - position) / speed 
			
func _on_area_2d_body_entered(body):
	print("entered")
	chase = true
	
func _on_area_2d_body_exited(body):
	print("exited")
	chase = false

func _on_hurtbox_body_entered(body):
	if "Bullet" in body.name or "@RigidBody2D@4" in body.name:
		health -= 1.5
	
