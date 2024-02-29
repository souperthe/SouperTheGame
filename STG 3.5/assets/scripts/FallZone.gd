extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.is_debug_build():
		$Fallzone.visible = true
	if !OS.is_debug_build():
		$Fallzone.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Area2D_area_entered(_area):
	print("wtf!")
	#global.camera.shake(25)
	if !objplayer.currentstate == ("bossdead"):
		dorespawn()
	if objplayer.currentstate == ("bossdead") && !objplayer.animator.animation == "slipland":
		objplayer.velocity.y = -670 * 2
		objplayer.velocity.x = 670
	if objplayer.currentstate == ("bossdead") && objplayer.animator.animation == "slipland":
		objplayer.velocity.y = -5
	
func dorespawn():
	objplayer.fall()
	
