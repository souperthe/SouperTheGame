extends CharacterBody2D
class_name DeadThing

@onready var sprite := $sprite
var hsp := 0.0
var vsp := 0.0
var grv := 0.6
var rotateamount := 0.2




func _physics_process(delta):
	vsp += grv
	sprite.rotation_degrees += rotateamount
	velocity.x = (hsp * 4000) * delta
	velocity.y = (vsp * 4000) * delta
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.
