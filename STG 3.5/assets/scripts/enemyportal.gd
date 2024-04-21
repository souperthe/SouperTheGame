extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Red2.visible = false
	$Red.visible = true
	$Red.scale.x = 5
	$Red.scale.y = 5
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("start")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Red.rotation_degrees += 2
	pass
