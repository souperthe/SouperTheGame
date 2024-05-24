extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fallzone.queue_free()
	$hurtblock/AnimatedSprite.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Area2D_area_entered(_area):
	print("wtf!")
	#global.camera.shake(25)
	if !objplayer.currentstate == ("bossdead"):
		objplayer.fall()
	if objplayer.currentstate == ("bossdead") && !objplayer.animator.animation == "slipland":
		objplayer.velocity.y = -670 * 2
		objplayer.velocity.x = 670
	if objplayer.currentstate == ("bossdead") && objplayer.animator.animation == "slipland":
		objplayer.velocity.y = -5
	
func dorespawn():
	objplayer.fall()
	


func _on_baddie_body_entered(body):
	if body is Baddie:
		body.dead(1000000)
	pass # Replace with function body.
