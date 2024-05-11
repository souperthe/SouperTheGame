extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Close_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_test_pressed():
	get_tree().quit()
	pass # Replace with function body.



func _on_Maxiumize_pressed():
	#music.stopmusic()
	#roomhandle.scenegoto("res://assets/scenes/dark.tscn")
	#OS.shell_open("CMD.exe")
	#OS.alert("You know what to do.", " ")
	OS.window_maximized = !OS.window_maximized
	if OS.window_maximized:
		OS.window_size.y -= 40
		#OS.set_window_position(OS.get_screen_position(OS.get_current_screen()) +  OS.get_screen_size()*0.5 - OS.get_window_size()*0.5)
	pass # Replace with function body.


func _on_Minumize_pressed():
	OS.set_window_minimized(true)
	pass # Replace with function body.
