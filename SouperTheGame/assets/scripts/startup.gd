extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	roomhandler.scenegoto("res://assets/scenes/test.tscn")
	queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
