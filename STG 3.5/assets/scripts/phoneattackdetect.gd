extends KinematicBody2D


var dead = false
var cutscene
var phonex 
var alreadyused 
var shake = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _process(delta):
	if cutscene:
		global.camerazoom = lerp(global.camerazoom, 0.5, 0.05)
		shake += 0.2
		global.camera.shake(shake)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func kill(speed):
	if !alreadyused:
		kill1(speed)
	if alreadyused:
		kill2(speed)
		
	
func explode():
	var whiteflash = preload("res://assets/objects/explosion.tscn")
	var ghost: RigidBody2D = whiteflash.instance()
	get_tree().get_current_scene().add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	
func kill1(blahh):
	music.stopmusic()
	objplayer.cutscene()
	objplayer.animator.stop()
	cutscene = true
	global.cutscene = true
	global.cinematicbar = true
	$CollisionShape2D.disabled = true
	var t = Timer.new()
	t.set_wait_time(1.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	dead = true
	explode()
	objplayer.hardtumble()
	objplayer.face = !objplayer.face
	objplayer.animator.flip_h = !objplayer.animator.flip_h 
	objplayer.position.x = phonex
	global.camerazoom = 1
	global.cutscene = false
	global.cinematicbar = false
	global.camera.shake(50)
	
func kill2(blah2):
	dead = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
