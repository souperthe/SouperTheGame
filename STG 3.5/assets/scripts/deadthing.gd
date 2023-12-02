extends KinematicBody2D


var jump = 900
var knockback = 50
var gravity = 35
var velocity := Vector2.ZERO
var spinamount = 2
onready var sprite = $Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	$Sprite.rotation_degrees += spinamount
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
