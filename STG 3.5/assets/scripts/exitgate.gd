extends Area2D

export (String) var targetdoor
export (String) var targetscene
export (bool) var timed_level = false
export (int) var timed_level_time = 60
var overdoor = false
var player
var doornotentered = true
onready var timer = $timer
var enter = true
var dick = false
var zoomin = false
var zoomin2 = false
var cutmusic = false
var glowpart = false
var entering = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.baddieroom.has(global.targetRoom2 + name)):
		queue_free()
	var t = Timer.new()
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	enter = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Door_body_entered(body):
	#("indoor")
	if body is Player:
		if doornotentered:
			body.makethingvisible()
		player = body
		$AnimatedSprite.play("indoor")
		overdoor = true


func _on_Door_body_exited(_body):
	if _body is Player:
		if doornotentered:
			_body.makethingnotvisible()
		$AnimatedSprite.play("outdoor")
		#print("outdoor")
		overdoor = false
	
func _physics_process(_delta):
	if entering and global.hardmode:
		if Input.is_key_pressed(KEY_F4):
			if !global.oldtodmode:
				global.oldtodmode = true
				objplayer.gun = false
				global.playsmall()
				music.playsong("res://assets/sound/todfuckedupevil.mp3")
				global.info("[shake rate=20.0 level=5 connected=1]Expert tod mode activated![/shake]", 4)
	$glow.z_index = objplayer.z_index - 1
	if cutmusic:
		music.stopmusic()
	if zoomin:
		#global.camerazoom = lerp(global.camerazoom, 0.5, 3 * _delta)
		pass
	if glowpart:
		$glow.scale.x += 0.05
		$glow.scale.y += 0.05
		objplayer.position = lerp(objplayer.position, global.camera.get_camera_screen_center(), 0.01)
		if $glow.scale.x > 15:
			roomhandle.scenegoto("res://assets/scenes/rankroom.tscn")
	if zoomin2:
		global.camerazoom = lerp(global.camerazoom, 1.11, 5 * _delta)
		if global.camerazoom > 0.999:
			global.cutscene = false
			global.camerazoom = 1
			zoomin2 = false
			if timed_level:
				killdoor()
	if global.panic and not dick:
		$ExitgateOpen.visible = true
		dick = true
		
	if overdoor and enter:
		#music.temp = 0
		exitgate()
		enter = false
	if global.panic and overdoor and player.candoor and doornotentered and !timed_level:
		if Inputs.just_key_up:
			global.makeflash()
			global.panic = false
			global.fill.paused = false
			zoomin = true
			player.makethingnotvisible()
			global.targetdoor = targetdoor
			doornotentered = true
			glowpart = true
			$glow.visible = true
			global.cutscene = true
			global.hidehud = true
			#music.stopmusic()
			player.cutscene()
			player.animator.play("enterdoor")
			player.animator.flip_h = false
			player.canhurt = false
			#player.position.x = position.x
			global.escapeexited = true
			global.lockcamera = true
			global.combotimer.paused = true
			global.countdown = false
			if global.rank == "1/5":
				music.playsong("res://assets/sound/music/mus_rank1.ogg")
			if global.rank == "2/5":
				music.playsong("res://assets/sound/music/mus_rank2.ogg")
			if global.rank == "3/5":
				music.playsong("res://assets/sound/music/mus_rank2.ogg")
			if global.rank == "4/5":
				music.playsong("res://assets/sound/music/mus_rank3.ogg")
			if global.rank == "5/5":
				music.playsong("res://assets/sound/music/mus_rank4.ogg")
			if global.rank == "6/5":
				music.playsong("res://assets/sound/music/mus_rank5.ogg")
			#enterdoor()



func _on_timer_timeout():
	doornotentered = false
	#ct._tout()
	global.room_goto(targetscene, targetdoor)
	ct._tout()
	player.exitdoor()


func _on_exitgate_body_entered(body):
	if body is Player:
		if doornotentered and global.panic:
			body.makethingvisible()
		player = body
		overdoor = true
	pass # Replace with function body.

func enterdoor():
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	#if global.level == "entrance":
		#global.write_save("house completed")
	$slam.play()
	$ExitgateOpen.visible = false
	player.animator.play("nothing")
	enterdoorsecondhalf()
	
func enterdoorsecondhalf():
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	ct._tin()
	var y = Timer.new()
	y.set_wait_time(1.0)
	y.set_one_shot(true)
	self.add_child(y)
	y.start()
	yield(y, "timeout")
	#global.room_goto("res://assets/scenes/rankroom.tscn", "none")
	global.escapeexited = false
	global.room_goto("res://assets/scenes/rankroom.tscn", "123123")
	player.animator.play("enterdoorfast")
	ct._tout()
	

	

func _on_exitgate_body_exited(body):
	if body is Player:
		if doornotentered and global.panic:
			body.makethingnotvisible()
		#print("outdoor")
		overdoor = false
	pass # Replace with function body.
	
func exitgate():
	if timed_level:
		global.timedlevel = true
	entering = true
	player.modulate = Color(0, 0, 0, 1)
	global.restartlevel = global.targetRoom2
	global.restartdoor = global.targetdoor
	music.temp = 0
	ct._treset()
	ct._tout()
	if global.hardmode:
		music.playmusic = false
		objplayer.gun = true
		music.playtod()
	if !global.hardmode:
		music.playmusic = true
	global.camerazoom = 0.5
	global.cutscene = true
	$ExitgateOpen.visible = true
	player.exitdoor()
	var t = Timer.new()
	t.set_wait_time(0.8)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	global.cutscene = false
	zoomin2 = true
	#global.makeflash()
	if global.hardmode:
		presobjs.createtod()
	entering = false
	$slam.play()
	global.camera.shake2(5, 0.2)
	cutmusic = false
	$ExitgateOpen.visible = false
	if timed_level:
		timedlevel()
	
func timedlevel():
	global.panic = true
	if !global.hardmode:
		global.fill.wait_time = timed_level_time
	if global.hardmode:
		global.fill.wait_time = timed_level_time / 2
		
func killdoor():
	hurteffect()
	hurteffect()
	hurteffect()
	playcock()
	explode()
	createdead2()
	playcock2()
	global.baddieroom.append(global.targetRoom2 + name)
	queue_free()
		
		
func hurteffect():
	var whiteflash = preload("res://assets/objects/hurtpartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.amount = 1000
	
func playcock():
	var whiteflash = preload("res://assets/objects/cocking.tscn")
	var ghost: AudioStreamPlayer2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.stream = load("res://assets/sound/sfx/sfx_destorymetal.wav")
	ghost.play()
	
func playcock2():
	var whiteflash = preload("res://assets/objects/cocking.tscn")
	var ghost: AudioStreamPlayer2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	#ghost.volume_db = -1.189
	ghost.position = self.position
	ghost.stream = load("res://assets/sound/sfx/sfx_hitwall.wav")
	ghost.play()
	
func explode():
	var whiteflash = preload("res://assets/objects/explosion.tscn")
	var ghost: RigidBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y - 32
	ghost.canhurt = false
	
func createdead2():
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.velocity.y = -900
	randomize()
	ghost.velocity.x = rand_range(-200,200)
	ghost.spinamount = rand_range(-10,10)
	ghost.sprite.texture = load("res://assets/sprites/exitgate_closed.png")
	
