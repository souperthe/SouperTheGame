extends KinematicBody2D


onready var alpha = $Funnyboulder.modulate.a8
var maxspeed = 8 / 10
var mvsp = (maxspeed + (abs(objplayer.velocity.x) / 8))
var velocity := Vector2.ZERO
var speed = 70350
var pause = false
var oldspeed = 8 * 7050 * 3
#var dir = Vector2.angle_to_point(position.x, position.y, (objplayer.position.x + objplayer.velocity.x), (objplayer.position.y + objplayer.velocity.y))


func _ready():
	#global.info("test", 10)
	#$ass.play()
	global.connect("reset", self, "destory")
	global.connect("scenechanged", self, "gotodoor")
	gotodoor()
	pass
	
	
func gotodoor():
	pause = false
	velocity = Vector2(0,0)
	$Funnyboulder.modulate.a8 = 0
	#position = objplayer.position
	#if roomhandle.currentscene.get_node("escapephone"):
		#pause = true
	if roomhandle.currentscene.get_node("treasure"):
		pause = true
	if pause:
		position = Vector2(297897,297897)
	if not pause:
		position.x = objplayer.position.x
		position.y = objplayer.position.y
		
func destory():
	queue_free()
	
	

	

func hurteffect():
	var whiteflash = preload("res://assets/objects/hurtpartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.amount = 500
	
func _physics_process(delta):
	if roomhandle.currentscene.name == "gameover":
		queue_free()
	if global.escapeexited == true:
		kill()
	velocity = move_and_slide(velocity, Vector2.UP)
	if global.hardmode and global.panicdone:
		speed += 30
	if $Funnyboulder.modulate.a8 > 251 and !global.cutscene and !objplayer.currentstate == ("EnterDoor") and !objplayer.currentstate == ("ExitDoor") and !objplayer.currentstate == ("bossdead") and !objplayer.currentstate == ("Nothing") and !pause:
		#position = lerp(position, objplayer.position, 3 * delta)
		#position = Vector2.slide(objplayer.position)
		#velocity = move_and_slide(velocity)
		trail()
		var mousepoint = objplayer.get_position()
		var vector = (mousepoint - self.get_position()).normalized()
		var goto = (vector * speed * delta)
		var oldgoto = (vector * oldspeed * delta)
		if !global.oldtodmode:
			velocity = lerp(velocity, goto, 1 * delta)
		if global.oldtodmode:
			velocity = lerp(velocity, oldgoto, 1.5 * delta)
		if $detect.overlaps_body(objplayer):
			if $Funnyboulder.modulate.a8 == 255:
				velocity = Vector2(0,0)
				#body.hurtplayer()
				kill()
				objplayer.doflash()
				objplayer.changestate("bossdead")
				$Funnyboulder.modulate.a8 = 0
	else:
		velocity.x = lerp(velocity.x, 0, 5 * delta)
		velocity.y = lerp(velocity.y, 0, 5 * delta)
	if $Funnyboulder.modulate.a8 < 255:
		if global.oldtodmode:
			$Funnyboulder.modulate.a8 += 1
		if !global.oldtodmode:
			$Funnyboulder.modulate.a8 += 3
	
#func _on_evilguy_body_entered(body):
	#if body is Player:
		#if $Funnyboulder.modulate.a8 == 255:
			#velocity = Vector2(0,0)
			##body.hurtplayer()
			#kill()
			#body.changestate("bossdead")
			#$Funnyboulder.modulate.a8 = 0
	#pass # Replace with function body.
	
	
	
func trail():
	if !$trailtimer.time_left > 0:
		$trailtimer.start()
	
func createtrail():
	var dashtrail = preload("res://assets/objects/playerdashtrail.tscn")
	var ghost: AnimatedSprite = dashtrail.instance()
	var animator = $Funnyboulder
	roomhandle.currentscene.add_child(ghost)
	ghost.playing = false
	ghost.flip_h = animator.flip_h
	ghost.global_position = global_position
	ghost.scale.x = animator.scale.x
	ghost.scale.y = animator.scale.y
	ghost.z_index = self.z_index - 1
	#ghost.position.y += -4.301
	ghost.frames = animator.frames
	ghost.animation = animator.animation
	ghost.frame = animator.frame
	ghost.rotation = animator.rotation
	ghost.modulate.r8 = 200
	ghost.modulate.g8 = 128
	ghost.modulate.b8 = 72


func _on_detect_body_entered(body):
	if body is Player:
		if $Funnyboulder.modulate.a8 == 255:
			#body.hurtplayer()
			body.changestate("bossdead")
			var rng = global.randi_range(1,3)
			if rng == 3:
				body.voicenegative()
			#if global.oldtodmode:
				#body.sfxburnscream.play()
			global.cutscene = true
			global.makeflash()
			global.camera.shake2(6, 0.5)
			#kill()
			$Funnyboulder.modulate.a8 = 0
	pass # Replace with function body.

func kill():
	createdead1(0, 0)
	queue_free()
	
func createdead1(velocityx, rotatespeed):
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.velocity.y = -900
	ghost.velocity.x = velocityx
	ghost.spinamount = -rotatespeed * 2
	ghost.sprite.texture = load("res://assets/sprites/animated/tod/tod_sad.png")
	ghost.sprite.scale.x = 0.6
	ghost.sprite.scale.y = 0.6
	
	
func goofysound():
	var whiteflash = preload("res://assets/objects/sillysfx3d.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.playsound = true
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	
	
func bangeffect(pos1):
	var whiteflash = preload("res://assets/objects/bangeffect.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = pos1.x
	ghost.position.y = pos1.y

func _on_attackdetect_body_entered(body):
	if $Funnyboulder.modulate.a8 == 255:
		bangeffect(body.position)
		body.queue_free()
		createdead1(body.velocity.x, body.velocity.x / 170)
		goofysound()
		hurteffect()
		global.camera.shake2(5, 0.05)
		$punchsoumd.dosound()
		hurteffect()
		$AnimationPlayer.play("flash")
		global.addcombo()
		#queue_free()
		$Funnyboulder.modulate.a8 = 0
	pass # Replace with function body.


func _on_trailtimer_timeout():
	createtrail()
	pass # Replace with function body.
