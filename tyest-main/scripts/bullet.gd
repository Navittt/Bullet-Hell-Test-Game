extends RigidBody2D


var velocity = Vector2(1, 0)
var speed = 1100
var damage = 2
signal hit(body, damage)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	var collision_info = move_and_collide(velocity.normalized()* delta * speed)


func _on_area_2d_body_entered(body):
	
	queue_free()
	
