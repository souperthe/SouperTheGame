extends KinematicBody2D


var jump = 900
var knockback = 50
var gravity = 1600
var velocity := Vector2.ZERO
var spinamount = 2
onready var sprite = $Sprite
var leave = true
var partical = true


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if partical:
		$runpart.emitting = true
	if !partical:
		$runpart.queue_free()
	$AnimationPlayer.play("flash")
	pass # Replace with function body.


func _physics_process(_delta):
	$Sprite.rotation_degrees += spinamount * _delta
	velocity.y += gravity * _delta
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_VisibilityNotifier2D_screen_exited():
	if leave:
		queue_free()
	pass # Replace with function body.
