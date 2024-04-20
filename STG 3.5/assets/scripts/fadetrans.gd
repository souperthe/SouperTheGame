extends ColorRect

onready var animation_player = $AnimationPlayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func fade_in():
	animation_player.play("fadein")
 
 
func fade_out():
	animation_player.play("fadeout")
	
func reset():
	animation_player.play("reset")
