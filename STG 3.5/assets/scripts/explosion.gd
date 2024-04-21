extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var canhurt = true
var onscreen = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if onscreen:
		global.camera.shake2(10, 0.4)
	$step.play()
	$AnimatedSprite.play("explode")
	$AnimatedSprite.frame = 0
	$CollisionShape2D.disabled = true
	pass # Replace with function body.


func _process(_delta):
	if !canhurt:
		if is_instance_valid($hurtblock):
			$hurtblock.queue_free()
	if $AnimatedSprite.frame > 2:
		if is_instance_valid($hurtblock):
			$hurtblock.queue_free()
	pass
	
	



func _on_step_finished():
	queue_free()
	pass # Replace with function body.


func _on_VisibilityEnabler2D_screen_entered():
	onscreen = true
	pass # Replace with function body.


func _on_VisibilityEnabler2D_screen_exited():
	onscreen = false
	pass # Replace with function body.
