extends CharacterBody2D
class_name Follower


var speed := 350


func _process(delta):
	velocity = position.direction_to(plr.position) * ((speed * 4000) * delta)
	move_and_slide()
