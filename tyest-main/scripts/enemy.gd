extends CharacterBody2D
var speed = 25
var chase = false
var motion = Vector2.ZERO
var health = 8
var aggro = false

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var aggro_timer: Timer = $aggro_timer


func _ready():
	progress_bar.value = health
	

func _physics_process(delta):
	progress_bar.value = health
	if health <= 0:
		queue_free()
	
	var player = get_parent().get_node("player")
	
	if chase:
		position += (player.position - position) / speed 
	
	if aggro == true:
		position += (player.position - position) / speed 
	
	
			
func _on_area_2d_body_entered(body):
	print("entered")
	chase = true

func _on_area_2d_body_exited(body):
	print("exited")
	chase = false

func _on_hurtbox_body_entered(body):
	var player = get_parent().get_node("player")
	if "Bullet" in body.name or "@RigidBody2D@4" in body.name:
		health -= 1.5
		aggro = true
		aggro_timer.start()
		print(body.name)

func _on_aggro_timer_timeout() -> void:
	aggro = false
	
	
func fire():
	pass
