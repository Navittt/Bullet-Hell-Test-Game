extends CharacterBody2D

const SPEED = 250
const JUMP_VELOCITY = -400.0
var dashing = false
var acceleration = 30
var friction = 50
var can_dash = true
var can_shoot = true
var bullet_speed = 35
const Bullet_Path = preload("res://scenes/bullet.tscn")
var can_melee = true
var health = 10
var timer_started = false
var can_move = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var timer = $"dash time"
@onready var dash_wait = $"dash wait"
@onready var shoot_wait = $"shoot wait"
@onready var animation = $AnimationPlayer
@onready var health_bar: ProgressBar = $HealthBar
@onready var deathtimer: Timer = $deathtimer
@onready var player: CharacterBody2D = $"."
@onready var BWONG: AudioStreamPlayer = $AudioStreamPlayer
@onready var can_be_hit: Timer = $can_be_hit

signal is_attackingg

func _ready():
	health_bar.value = health


func _physics_process(delta):
	health_bar.value = health
	if health <= 0:
		if not timer_started:
			timer_started = true
			$deathtimer.start()
			BWONG.play()
			can_move = false
			
	
	if Input.is_action_just_pressed("dash") and can_dash:
		dash_wait.start()
		can_dash = false
		dashing = true
		timer.start()
	if can_move:
		var direction = Input.get_vector("left", "right", "up", "down")
		position += direction * SPEED * delta
	
		if dashing:
			position += direction * 680 * delta
		else:
			position += direction * SPEED * delta
	
		move_and_collide(direction)

	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		can_shoot = false
		shoot_wait.start()
		shoot()
		
	$Node2D.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("melee") and can_melee:
		emit_signal("is_attackingg")
		print("sent")
		melee()
	
	
func shoot():
	var bullet = Bullet_Path.instantiate()
	
	get_parent().add_child(bullet)
	
	bullet.position = $Node2D/Marker2D.global_position
	
	bullet.velocity = get_global_mouse_position() - bullet.position
	
func melee():
	animation.play("attack")
	
	
func _on_timer_timeout():
	dashing = false


func _on_dash_wait_timeout():
	can_dash = true


func _on_shoot_wait_timeout():
	can_shoot = true
	
func _on_hurtbox_body_entered(body: Node2D) -> void:
	if "enemy" in body.name:
		health -= 2
		print(health)
		print(body.name)

func _on_deathtimer_timeout() -> void:
	player.get_tree().reload_current_scene()
