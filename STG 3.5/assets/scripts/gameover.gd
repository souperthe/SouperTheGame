extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	music.stopmusic()
	$AnimationPlayer.play("gameover")
	objplayer.animator.play("caught")
	objplayer.animator.rotation_degrees = 0
	objplayer.disabletitlt = true
	objplayer.cutscene()
	global.panic = false
	#global.camera.shake(3,3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func effects():
	objplayer.animator.play("nothing")
	deadgun()
	
	
func deadgun():
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = objplayer.position.x
	ghost.position.y = objplayer.position.y
	ghost.velocity.y = -700
	ghost.velocity.x = rand_range(-360,360)
	ghost.spinamount = rand_range(-200,200)
	ghost.sprite.rotation_degrees = rand_range(-360,360)
	randomize()
	ghost.sprite.texture = load("res://assets/sprites/player_souper/souperanim_0069.png")
	ghost.sprite.scale.x = 0.56
	ghost.sprite.scale.y = 0.56
	
func returntotitle():
	global.room_goto("res://assets/scenes/newTitle.tscn", "door1")
