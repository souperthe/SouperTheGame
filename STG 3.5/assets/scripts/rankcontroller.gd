extends Node2D


var done = false
var tit = false
var results = false
var t = 0.0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/ranks.play("nothing")
	$CanvasLayer/ParallaxBackground/ParallaxLayer/ColorRect.visible = true
	$CanvasLayer/ParallaxBackground/ParallaxLayer/ColorRect.visible = true
	$CanvasLayer/ParallaxBackground/ParallaxLayer/bg.visible = false
	objplayer.animator.play("enterdoorfast")
	objplayer.cutscene()
	global.cutscene = false
	objplayer.position.y = 900
	startrankthing()
	pass # Replace with function body.


func _process(delta):
	if !results and $CanvasLayer/ranks.frame > 11:
		if Inputs.just_key_jump:
			results()
			changebg()
			tit = true
	if done:
		if $CanvasLayer/ranks.frame > 11:
			if not tit:
				changebg()
				tit = true
				goback()
#t = 200
#objplayer.position.y = ease(objplayer.position.y, 270)
#objplayer.position.x = ease(objplayer.position.x, 480)
	#objplayer.position = lerp(objplayer.position, Vector2(480,270), 1.5 * delta)
	pass
	
func rankanimation():
	var t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	objplayer.animator.play("nothing")
	$CanvasLayer/ranks.visible = true
	$CanvasLayer/ranks.play("didntfinish")
	if global.rank == "1/5":
		$CanvasLayer/ranks.play("rank1")
	if global.rank == "2/5":
		$CanvasLayer/ranks.play("rank2")
	if global.rank == "3/5":
		$CanvasLayer/ranks.play("rank3")
	if global.rank == "4/5":
		$CanvasLayer/ranks.play("rank4")
	if global.rank == "5/5":
		$CanvasLayer/ranks.play("rank5")
	
func startrankthing():
	rankanimation()
	#$AudioStreamPlayer.play()
	done = true

func changebg():
	global.makeflash()
	$CanvasLayer/ParallaxBackground/ParallaxLayer/ColorRect.visible = false
	$CanvasLayer/ParallaxBackground/ParallaxLayer/bg.visible = true
	
func goback():
	var t = Timer.new()
	t.set_wait_time(22)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	if !results:
		results()

func hurteffect():
	var whiteflash = preload("res://assets/objects/hurtpartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = $CanvasLayer/deadposition.rect_position
	ghost.amount = 500
	ghost.scale = Vector2(1,1)

func createdead1(velocityx, rotatespeed):
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = $CanvasLayer/deadposition.rect_position.x
	ghost.position.y = $CanvasLayer/deadposition.rect_position.y
	ghost.velocity.y = -900 * 2
	ghost.leave = false
	ghost.velocity.x = velocityx
	ghost.spinamount = -1
	ghost.sprite.texture = load("res://assets/sprites/animated/ranks/rankdead_souper.png")
	ghost.sprite.scale.x = 1
	ghost.sprite.scale.y = 1
	ghost.gravity = 1600 * 2
	
func goofysound():
	var whiteflash = preload("res://assets/objects/sillysfx3d.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.playsound = true
	ghost.position = $CanvasLayer/deadposition.rect_position

func results():
	music.playsong("res://assets/sound/music/results.ogg")
	results = true
	#global.makeflash()
	$CanvasLayer/ranks.visible = false
	createdead1(-900, 5)
	hurteffect()
	goofysound()
	$CanvasLayer/deadposition/punchsoumd.dosound()
	pass
