extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dead
var yes = false


# Called when the node enters the scene tree for the first time.
func _ready():
	objplayer.reset()
	music.stopmusic()
	$AnimationPlayer.play("gameover")
	objplayer.animator.play("caught")
	objplayer.animator.rotation_degrees = 0
	objplayer.disabletitlt = true
	objplayer.cutscene()
	global.panic = false
	global.camerazoom = 1
	#global.camera.shake(3,3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if dead:
		if dead.position.y > 540 + 32:
			if !yes:
				yes = true
				#global.playsmallnew()
				global.playsound(dead.position, "res://assets/sound/sfx/sfx_fallzoneland.wav")
				objplayer.cutvoices()
				hurteffect(dead.position)
				hurteffect(dead.position)
				hurteffect(dead.position)
				bangeffect(dead.position)
				punchsound(dead.position)
				dead = null
#	pass

func hurteffect(pos):
	var whiteflash = preload("res://assets/objects/hurtpartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = pos
	ghost.amount = 1000
	
func punchsound(pos):
	var whiteflash = preload("res://assets/objects/punchsoumddelete.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = pos
	ghost.dosound = true
	
func bangeffect(pos):
	var whiteflash = preload("res://assets/objects/bangeffect.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = pos.x
	ghost.position.y = pos.y - 15


func effects():
	objplayer.animator.play("nothing")
	global.greenkey = false
	objplayer.haskey = false
	var rng = global.randi_range(1,2)
	if rng == 2:
		objplayer.voicenegative()
	deadgun()
	
	
func deadgun():
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = objplayer.position.x
	ghost.position.y = objplayer.position.y
	ghost.velocity.y = -700
	ghost.velocity.x = rand_range(-360,360)
	ghost.spinamount = rand_range(-800,800)
	ghost.sprite.rotation_degrees = rand_range(-360,360)
	randomize()
	ghost.sprite.texture = load("res://assets/sprites/player_souper/souperanim_0069.png")
	ghost.sprite.scale.x = 0.56
	ghost.sprite.scale.y = 0.56
	dead = ghost
	
func returntotitle():
	global.room_goto("res://assets/scenes/newTitle.tscn", "door1")
