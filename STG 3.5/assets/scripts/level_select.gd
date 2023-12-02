extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$arrow.play("default")
	$arrow2.play("default")
	objplayer.gooffscreen()
	ct._tout()


