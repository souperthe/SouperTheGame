extends Node2D


var done = false
var tit = false
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
	ct._tin()
	var e = Timer.new()
	e.set_wait_time(2)
	e.set_one_shot(true)
	self.add_child(e)
	e.start()
	yield(e, "timeout")
	global.room_goto("res://assets/scenes/newTitle.tscn", "door1")
	ct._tout()
