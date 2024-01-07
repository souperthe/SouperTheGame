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
	if !objplayer.currentstate == ("bossdead"):
		dorespawn()
	if objplayer.currentstate == ("bossdead") && !objplayer.animator.animation == "slipland":
		objplayer.velocity.y = -670 * 2
		objplayer.velocity.x = 670
	
func dorespawn():
	objplayer.cutscene()
	global.combotimer.paused = true
	yield(get_tree().create_timer(0.5), "timeout")
	ct._tin()
	yield(get_tree().create_timer(0.5), "timeout")
	ct._tout()
	global.combotimer.paused = false
	presobjs.player2respawn()
	objplayer.respawn()
	
