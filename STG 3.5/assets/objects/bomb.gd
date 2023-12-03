extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timertime = 2
var gravity = 35
var velocity := Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = timertime
	$Timer.start()
	$step.play()
	pass # Replace with function body.


func _process(delta):
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0, 10 * delta)
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Timer_timeout():
	explode()
	queue_free()
	pass # Replace with function body.
	
func explode():
	var whiteflash = preload("res://assets/objects/explosion.tscn")
	var ghost: RigidBody2D = whiteflash.instance()
	get_tree().get_current_scene().add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
