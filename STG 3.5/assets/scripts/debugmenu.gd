extends CanvasLayer

var plr = preload("res://assets/objects/player2.tscn")
var enabled = false
var selectedroom

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if Input.is_action_just_pressed("player2"):
		if enabled:
			if !presobjs.player2:
				createplayer2()
	$Control/noclip.visible = !objplayer.currentstate == "Noclip"
	$Control/plrstate.text = str("PLAYER STATE: ", objplayer.currentstate)
	$Control/fps.text = (str("FPS: ", Engine.get_frames_per_second()))
	$Control/plrspos.text = (str("PLAYER POSITION: ", objplayer.position))
	$Control/plrsvol.text = (str("PLAYER VELOCITY: ",objplayer.velocity / 60))
	$Control/plranimation.text = (str("PLAYER ANIMATION: ",objplayer.animator.animation))
	$Control/plranimation2.text = (str("GAME DELTA: ",delta))
	$Control.visible = enabled
	$Control/smoothamount.visible = global.camerasmoothing
	global.cameraspeed = float($Control/smoothamount.text)
	Engine.time_scale = float($Control/gamespeed.text)
	if Input.is_action_just_pressed("debugmenu"):
		#if OS.is_debug_build():
		enabled = !enabled
		#$AudioStreamPlayer.play()




func _on_escapecheck_pressed():
	if enabled == true:
		global.panic = !global.panic


func _on_escapecheck2_pressed():
	if enabled == true:
		global.camerasmoothing = !global.camerasmoothing
	pass # Replace with function body.


func _on_escapecheck3_pressed():
	if enabled == true:
		global.showcolloisions = !global.showcolloisions
	pass # Replace with function body.
	
	
func createplayer2():
	if !presobjs.player2:
			var ghost: KinematicBody2D = plr.instance()
			presobjs.add_child(ghost)
			presobjs.player2 = ghost
			ghost.velocity.x = 0
			ghost.velocity.y = 0
			ghost.position.x = objplayer.position.x
			ghost.position.y = objplayer.position.y
			presobjs.player2.formenter.play()
	


func _on_spawngun_pressed():
	var whiteflash = preload("res://assets/objects/guncollect.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = objplayer.position.x
	ghost.position.y = objplayer.position.y
	pass # Replace with function body.


func _on_spawnboombox_pressed():
	var whiteflash = preload("res://assets/objects/boombox.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = objplayer.position.x
	ghost.position.y = objplayer.position.y
	pass # Replace with function body.


func _on_noclip_pressed():
	if !objplayer.currentstate == "Noclip":
		objplayer.changestate("Noclip")
	pass # Replace with function body.


func _on_spawnboombox2_pressed():
	$Control/FileDialog.popup()
	#global.room_goto(global.targetRoom2, global.targetdoor)
	#objplayer.reset()
	pass # Replace with function body.


func _on_spawnboombox3_pressed():
	objplayer.fall()
	pass # Replace with function body.


func _on_FileDialog_file_selected(path):
	selectedroom = path
	global.room_goto(path, "door1")
	pass # Replace with function body.
