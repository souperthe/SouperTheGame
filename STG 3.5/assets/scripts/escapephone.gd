extends Area2D

var overphone
var player
var tit = false
var a = false
var zoomin = false
var talkfinsihed = false
var cutsceneplaying = false
onready var secondtimer = $brahh
export (int) var escapetime
var rang = RandomNumberGenerator.new()
var random
var used = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var whiteflash = preload("res://assets/objects/deadthing.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("ring")
	$AnimatedSprite.frame = 0
	#$ring.play()
	if global.panic:
		queue_free()
	pass # Replace with function body.


func _process(delta):
	$attackdetect.phoney = self.position.y
	
	$attackdetect.phonex = self.position.x
	$attackdetect.alreadyused = tit
	if $attackdetect.cutscene:
		$AnimatedSprite.stop()
		$ring2.stop()
	if $attackdetect.dead == true:
		if not tit:
			hurt()
		if tit:
			hurt2()
	if $AnimatedSprite.animation == "ring":
		if $AnimatedSprite.frame == 10:
			if !$ring2.playing:
				$ring2.play()
	if tit and talkfinsihed and not a:
		player.animator.play("onphonewtf")
		a = true
	if !zoomin and used:
		global.camerazoom = lerp(global.camerazoom,  1.11, 5 * delta)
		if global.camerazoom > 0.999:
			global.camerazoom = 1
		global.cinematicbar = false
	if zoomin and used:
		global.camerazoom = lerp(global.camerazoom, 0.5, 2 * delta)
		global.cinematicbar = true
	if !global.hardmode and overphone and player.candoor and player.currentstate == "Idle" and not tit:
		if Inputs.just_key_up:
			used = true
			global.combotimer.paused = true
			player.makethingnotvisible()
			cutsceneplaying = true
			tit = true
			music.stopmusic()
			$AnimatedSprite.play("pickedup")
			$ring2.stop()
			$ring.stop()
			$pickip.play()
			player.cutscene()
			player.animator.play("onphone")
			global.cutscene = true
			zoomin = true
			cutscene()
			
	if cutsceneplaying:
		if Inputs.just_key_attack:
			cutscene2nowait()
			
	pass


func _on_escapephone_body_entered(body):
	if body is Player:
		player = body
		overphone = true
		if not tit and !global.hardmode:
			body.makethingvisible()
	pass # Replace with function body.


func _on_escapephone_body_exited(body):
	if body is Player:
		overphone = false
		if not tit and !global.hardmode:
			body.makethingnotvisible()
	pass # Replace with function body.
	
func cutscene():
	var t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	if cutsceneplaying:
		$talk.play()
		cutscene2()

	
func cutscene2():
	if cutsceneplaying:
		secondtimer.start()
	if !cutsceneplaying:
		secondtimer.stop()
	yield(secondtimer, "timeout")
	cutscene2nowait()
	
func cutscene2nowait():
	$AnimatedSprite.play("punch")
	$AnimatedSprite.flip_h = position.x < player.position.x
	secondtimer.stop()
	$talk.stop()
	global.makeflash()
	global.panic = true
	if !global.hardmode:
		global.fill.wait_time = escapetime
	if global.hardmode:
		global.fill.wait_time = escapetime / 2
	zoomin = false
	global.cutscene = false
	player.hardtumble()
	$hurt1.play()
	player.hitpartical()
	player.face = !player.face
	player.animator.flip_h = !player.animator.flip_h 
	player.position.x = self.position.x
	player.velocity.x = -800
	player.velocity.y = -15
	createdead2()
	$impact.play()
	global.combotimer.paused = false
	global.addcombo()
	cutsceneplaying = false
	
func breakphone():
	if not tit:
		hurt()
	
func hurt():
	global.makeflash()
	global.panic = true
	global.fill.wait_time = escapetime
	global.addcombo()
	createdead1()
	createdead2()
	playcock()
	playcock2()
	hurteffect()
	global.phonescreen = false
	queue_free()
	
func hurt2():
	global.addcombo()
	createdead1()
	playcock()
	hurteffect()
	global.phonescreen = false
	queue_free()
	
	
func createdead1():
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.velocity.y = -900
	ghost.velocity.x = 100
	
	
func createdead2():
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.velocity.y = -1010
	ghost.velocity.x = 50
	ghost.spinamount = 15
	ghost.sprite.texture = load("res://assets/sprites/animated/escapephone/phone.png")
	
	
func playcock():
	var whiteflash = preload("res://assets/objects/cocking.tscn")
	var ghost: AudioStreamPlayer2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.stream = load("res://assets/sound/sfx/sfx_destorymetal.wav")
	ghost.play()
	
func playcock2():
	var whiteflash = preload("res://assets/objects/cockingnot3d.tscn")
	var ghost: AudioStreamPlayer = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.volume_db = -1.189
	ghost.stream = load("res://assets/sound/sfx/sfx_impact2.wav")
	ghost.play()
	
func hurteffect():
	var whiteflash = preload("res://assets/objects/hurtpartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.amount = 500
	
	


func _on_talk_finished():
	talkfinsihed = true
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_entered():
	global.phonescreen = true
	pass # Replace with function body.


func _on_escapephone_area_exited(area):
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	global.phonescreen = false
	pass # Replace with function body.
