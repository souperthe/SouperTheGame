extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.scale.x = 1
	$AnimatedSprite.scale.y = 1
	z_index = 0
	$AnimatedSprite.play("default")
	$AnimatedSprite.frame = 0
	pass # Replace with function body.


func _process(_delta):
	#if $AnimatedSprite.frame > 3:
		#queue_free()
	pass


func _on_AnimatedSprite_animation_finished():
	queue_free()
	pass # Replace with function body.
