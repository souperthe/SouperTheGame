extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$step.play()
	$AnimatedSprite.play("explode")
	$AnimatedSprite.frame = 0
	$CollisionShape2D.disabled = true
	pass # Replace with function body.


func _process(delta):
	if $AnimatedSprite.frame > 2:
		if is_instance_valid($hurtblock):
			$hurtblock.queue_free()
	pass
	
	



func _on_step_finished():
	queue_free()
	pass # Replace with function body.
