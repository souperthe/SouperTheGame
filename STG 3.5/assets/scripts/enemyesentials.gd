extends Node2D

var onscreen = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_entered():
	onscreen = true
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	onscreen = false
	pass # Replace with function body.


func _on_lavacheck_body_entered(body):
	owner.dead(0)
	owner.punchsound()
	pass # Replace with function body.
