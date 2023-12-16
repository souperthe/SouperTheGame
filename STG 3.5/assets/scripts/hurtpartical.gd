extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var amount = 7


# Called when the node enters the scene tree for the first time.
func _ready():
	$hitpart1.emitting = true
	$hitpart2.emitting = true
	$hitpart3.emitting = true
	$hitpart1.amount = amount
	$hitpart2.amount = amount
	$hitpart3.amount = amount
	pass # Replace with function body.


func _process(_delta):
	if $hitpart1.emitting == false:
		queue_free()
	pass
