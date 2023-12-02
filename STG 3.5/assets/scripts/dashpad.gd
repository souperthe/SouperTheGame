extends Area2D

export (bool) var crazy
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if overlaps_body(objplayer):
		if !objplayer.currentstate == ("Mach3") or !objplayer.currentstate == ("Mach2"):
			$swash.play()
		if not crazy:
			objplayer.changestate("Mach2")
		if crazy:
			objplayer.changestate("Mach3")
		if scale.x == 1:
			objplayer.face = false
			objplayer.animator.flip_h = false
		if scale.x == -1:
			objplayer.face = true
			objplayer.animator.flip_h = true
	pass
