extends CanvasLayer

var plr = preload("res://assets/objects/player2.tscn")
var enabled = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	if Input.is_action_just_pressed("player2"):
		if enabled:
			if !presobjs.player2:
				createplayer2()
	$Control/plrstate.text = str("PLAYER STATE: ", objplayer.currentstate)
	$Control/fps.text = (str("FPS: ", Engine.get_frames_per_second()))
	$Control/plrspos.text = (str("PLAYER POSITION: ", objplayer.position))
	$Control/plrsvol.text = (str("PLAYER VELOCITY: ",objplayer.velocity))
	$Control/plranimation.text = (str("PLAYER ANIMATION: ",objplayer.animator.animation))
	$Control.visible = enabled
	$Control/smoothamount.visible = global.camerasmoothing
	global.cameraspeed = float($Control/smoothamount.text)
	Engine.time_scale = float($Control/gamespeed.text)
	if Input.is_action_just_pressed("debugmenu"):
		enabled = !enabled




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
	get_tree().get_current_scene().add_child(ghost)
	ghost.position.x = objplayer.position.x
	ghost.position.y = objplayer.position.y
	pass # Replace with function body.


func _on_spawnboombox_pressed():
	var whiteflash = preload("res://assets/objects/boombox.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	get_tree().get_current_scene().add_child(ghost)
	ghost.position.x = objplayer.position.x
	ghost.position.y = objplayer.position.y
	pass # Replace with function body.
