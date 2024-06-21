extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var found = false
var a = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("unfound")
	if (global.collectablesroom.has(global.targetRoom2 + name)):
		found = true
		$AnimatedSprite.play("foundloop")
	pass # Replace with function body.

func numberthing(amount):
	var dashtrail = preload("res://assets/objects/smallnumber.tscn")
	var ghost: Node2D = dashtrail.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y - 64
	ghost.number = str(amount)
	
	
func _process(delta):
	a = float(0.1 * global.secretsfound / 2)
	if overlaps_body(objplayer):
		if !found:
			found = true
			if global.secretsfound < 4:
				dothing()
			else:
				createdead1(objplayer.velocity.x)
				global.resetcombo()
				punchsound()
				hurteffect()
				bangeffect()
				queue_free()
			#OS.alert(str(a), "yea")
	pass
	
func hurteffect():
	var whiteflash = preload("res://assets/objects/hurtpartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y - 64
	ghost.amount = 1000

func bangeffect():
	var whiteflash = preload("res://assets/objects/bangeffect.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y - 64
	
	
func punchsound():
	var whiteflash = preload("res://assets/objects/punchsoumddelete.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.dosound = true
	
func createdead1(velocityx):
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y - 64
	ghost.velocity.y = rand_range(-1000,-1050)
	ghost.velocity.x = velocityx * 1.1
	ghost.spinamount = rand_range(-200,200)
	#ghost.spinamount = 0
	ghost.sprite.rotation_degrees = rand_range(-360,360)
	randomize()
	ghost.sprite.texture = load("res://assets/sprites/animated/secretflag/secretflag_0002.png")
	ghost.sprite.flip_h = $AnimatedSprite.flip_h
	ghost.sprite.scale.x = $AnimatedSprite.scale.x
	ghost.sprite.scale.y = $AnimatedSprite.scale.y
	
func dothing():
	global.secretsfound += 1
	global.addscore(1000)
	numberthing("+1000")
	global.collectablesroom.append(global.targetRoom2 + name)
	$AnimatedSprite.play("found")
	$yay.play()
	$yay.pitch_scale = $yay.pitch_scale + a
	var rng = global.randi_range(1,3)
	if rng == 3:
		objplayer.voicepositive()
	
