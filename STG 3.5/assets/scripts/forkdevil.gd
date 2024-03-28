extends KinematicBody2D

var dead = false
var is_movingleft = true
var gravity = 35
var velocity := Vector2.ZERO
var speed = 200
var deadjump = false
var rang = RandomNumberGenerator.new()
var random
var killed = false
var scared = false
var canbescared = true
var candie = true
var thing
var trail = false
onready var col = $collison
onready var check = $hitcheck/check
onready var tiltcheck = $tilcheck
onready var machcheck = $machdetect
onready var animator = $AnimatedSprite
onready var hurtpart = $hurtblock
var rotatespeed = 0.2


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$hurtblock2.canhurt = 0
	if (global.baddieroom.has(global.targetRoom2 + name)):
		queue_free()
	$hurtblock.visible = false
	machcheck.enabled = true
	if killed:
		kill(0)
	pass # Replace with function body.
	
	
func hitpart():
	$hitpart1.emitting = true
	$hitpart2.emitting = true
	$hitpart3.emitting = true


func _physics_process(_delta):
	if global.oldtodmode:
		queue_free()
	if animator.animation == ("attack"):
		dashtrail()
	thing = position.x < objplayer.position.x
	var my_random_number2 = rang.randi_range(1, 6)
	random = my_random_number2
	$hurtblock2.visible = false
	#print(random)
	if not scared:
		detect_turn()
	_move()
	if not dead:
		_scared()
		if not scared:
			#_tilt()
			animate()
	if dead:
		$AnimatedSprite.rotation_degrees += rotatespeed
		$AnimatedSprite.play("dead")
		
func _on_hitcheck_area_entered(_area):
	#if not dead:
		#kill()
		
	#dead = true
	#queue_free()
	pass
	
func _move():
	if not scared and not dead:
		velocity.x = -speed if is_movingleft else speed
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
func detect_turn():
	if not $RayCast2D.is_colliding() or $walldec.is_colliding():
		if is_on_floor():
			is_movingleft = !is_movingleft
			scale.x = -scale.x
		pass

func kill(sdhagdhqwjdawaw):
	var yadda = sdhagdhqwjdawaw
	if candie:
		killreal(yadda)
		
func killreal(sdhagdhqwjdawaw222):
	col.queue_free()
	$anim.play("hurt")
	hurtpart.canhurt = 0
	deadsound()
	global.addcombo()
	hitpart()
	velocity.y -= 900
	velocity.x = sdhagdhqwjdawaw222
	rotatespeed = sdhagdhqwjdawaw222 / 200 
	dead = true
	global.baddieroom.append(global.targetRoom2 + name)
	var t = Timer.new()
	t.set_wait_time(4)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	queue_free()
		
func deadsound():
	#var my_random_number2 = rang.randi_range(1, 2)
	#print(my_random_number2)
	if random == 6:
		$hurt6.play()
	if random == 5:
		$hurt5.play()
	if random == 4:
		$hurt4.play()
	if random == 3:
		$hurt3.play()
	if random == 2:
		$hurt2.play()
	if random == 1:
		$hurt1.play()
	pass
	
	
func animate():
	if velocity.x == 0:
		$AnimatedSprite.play("idle")
	if velocity.x != 0:
		$AnimatedSprite.play("walk")
		
		
func _tilt():
	if self.is_on_floor() and tiltcheck.is_colliding() and !dead:
		var normal = tiltcheck.get_collision_normal()
		var _thing = lerp(animator.rotation, normal.angle() + deg2rad(90), 0.3)
		if scale.x == 1:
			animator.rotation = lerp(animator.rotation, normal.angle() + deg2rad(90), 0.3)
		if scale.x == -1:
			animator.rotation = lerp(animator.rotation, normal.angle() - deg2rad(90), 0.3)
		#self.rotation = normal.angle() + deg2rad(90)
	else:
		if not dead:
			animator.rotation = 0
		#self.rotation = 0
		
func _scared():
	if machcheck.is_colliding() and not scared and canbescared and !global.hardmode:
		bescared()
		scared = true
	if machcheck.is_colliding() and not scared and global.hardmode:
		scared = true
		candie = false
		trail = true
		$swing.play()
		hardmodeattack()
		
func bescared():
	machcheck.enabled = false
	hurtpart.canhurt = 0
	velocity.x = 0
	velocity.y -= 350
	$AnimatedSprite.play("scared")
	scaredwait()
	
	
func hardmodeattack():
	machcheck.enabled = true
	$hurtblock2.canhurt = 1
	hurtpart.canhurt = 0
	var attackspeed = 600
	if thing:
		velocity.x = attackspeed
	if !thing:
		velocity.x = -attackspeed
	velocity.y = 0
	$AnimatedSprite.play("attack")
	attackwait()
	
func scaredwait():
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	machcheck.enabled = true
	hurtpart.canhurt = 1
	scared = false
	candie = true
	
func attackwait():
	var t = Timer.new()
	t.set_wait_time(0.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	machcheck.enabled = true
	$hurtblock2.canhurt = 0
	trail = false
	hurtpart.canhurt = 1
	scared = false
	candie = true
	
	
func dashtrail():
	var dashtrail = preload("res://assets/objects/playerdashtrail.tscn")
	var ghost: AnimatedSprite = dashtrail.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.playing = false
	ghost.flip_h = is_movingleft
	ghost.global_position = global_position
	#ghost.position.y += -4.301
	ghost.frames = animator.frames
	ghost.z_index = self.z_index - 1
	ghost.animation = animator.animation
	ghost.frame = animator.frame
	ghost.rotation = animator.rotation
	ghost.scale.x = animator.scale.x
	ghost.scale.y = animator.scale.y








	

