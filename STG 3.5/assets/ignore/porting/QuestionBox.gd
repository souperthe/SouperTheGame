extends "res://scripts/basebrick.gd"


func _ready():
	$KinematicBody2D/Sprite/AnimationPlayer.current_animation = "Blink"
	$KinematicBody2D/Sprite/AnimationPlayer.play()


func deactivate():
	.deactivate()
	$KinematicBody2D/Sprite/AnimationPlayer.current_animation = "Deactivate"
