extends Area2D

var player
var onthing = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

			


func _on_snowguy_body_entered(body):
	if body is Player:
		body.snow()
	pass # Replace with function body.

