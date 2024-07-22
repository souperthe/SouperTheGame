extends Node2D

var onscreen := false

func _on_visible_on_screen_notifier_2d_screen_entered():
	onscreen = true
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	onscreen = false
	pass # Replace with function body.
