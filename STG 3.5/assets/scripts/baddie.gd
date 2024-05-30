class_name Baddie
extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum states {
	normal,
	stun,
	scared,
	inactive,
	other
}
var direction = false
var numdirection = 1
var gravity = 35
var velocity := Vector2.ZERO
var speed = 200
var a = false
var canhurt = true
export var escape = false
var spawned = false
var sprite_size = Vector2(0.56,0.56)

var state = states.normal

var health = 1
var maxhealth = 1
var stuntimer = 60
var scaredtimer = 60
var flungvelocity = 0
var deadsprite = "res://assets/sprites/animated/testenemy/dead.png"
onready var animator = $animator

# Called when the node enters the scene tree for the first time.
func _ready():
	if escape:
		state = states.inactive
		if !global.panic:
			queue_free()
		if (global.escaperoom.has(global.targetRoom2 + name)):
			queue_free()
	if !escape:
		if (global.baddieroom.has(global.targetRoom2 + name)):
			queue_free()
	maxhealth = health
	pass # Replace with function body.

func hurteffect():
	var whiteflash = preload("res://assets/objects/hurtpartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.amount = 1000

func bangeffect():
	var whiteflash = preload("res://assets/objects/bangeffect.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y - 15
	
func portalffect():
	var whiteflash = preload("res://assets/objects/enemyportal.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y - 15
	
func punchsound():
	var whiteflash = preload("res://assets/objects/punchsoumddelete.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.dosound = true
	
func kill(sdhagdhqwjdawaw):
	var yadda = sdhagdhqwjdawaw
	#hurteffect()
	punchsound()
	if canhurt:
		if !state == states.stun:
			if health > 1:
				bangeffect()
				hurteffect()
				hurteffect()
				state = states.stun
				velocity.y = -600
				velocity.x = yadda * 2
				flungvelocity = yadda
				canhurt = false
				$AnimationPlayer.play("stun")
				animator.play("stun")
				global.resetcombo()
				health -= 1
				stuntimer = 60
			else:
				dead(yadda)

func slopetilt():
	var raycast = $enemyesentials/tilcheck
	if is_on_floor() and raycast.is_colliding():
		var normal = raycast.get_collision_normal()
		#animator.rotation = normal.angle() + deg2rad(90)
		animator.rotation = lerp(animator.rotation, normal.angle() + deg2rad(90), 0.3)
		#self.rotation = norm1l.angle() + deg2rad(90)
	else:
		animator.rotation = 0
	
func dead(p):
	hurteffect()
	hurteffect()
	#if $enemyesentials.onscreen:
	global.addcombo()
	bangeffect()
	#global.playsound(position, "res://assets/sound/owsfx.tres")
	if escape:
		global.escaperoom.append(global.targetRoom2 + name)
	if !escape:
		global.baddieroom.append(global.targetRoom2 + name)
	createdead1(p)
	global.camera.shake2(rand_range(5,10), 0.1)
	randomize()
	queue_free()

func createdead1(velocityx):
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.velocity.y = rand_range(-1000,-1050)
	ghost.velocity.x = velocityx * 1.1
	ghost.spinamount = rand_range(-200,200)
	#ghost.spinamount = 0
	ghost.sprite.rotation_degrees = rand_range(-360,360)
	randomize()
	ghost.sprite.texture = load(deadsprite)
	ghost.sprite.flip_h = animator.flip_h
	ghost.sprite.scale.x = sprite_size.x
	ghost.sprite.scale.y = sprite_size.y
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(_delta):
	$enemyesentials/enemyhealth.visible = health < maxhealth
	$animator.scale = lerp($animator.scale, sprite_size, 8 * _delta)
	$CollisionShape2D.disabled = state == states.inactive
	$enemyesentials/enemyhealth/pivot/BackBufferCopy/ProgressBar.value = health
	$enemyesentials/enemyhealth/pivot/BackBufferCopy/ProgressBar.max_value = maxhealth
	if global.oldtodmode:
		queue_free()
	slopetilt()
	if global.panic:
		if escape:
			if $enemyesentials.onscreen:
				if !spawned:
					spawned = true
					state = states.normal
					visible = true
					portalffect()
	if state != states.inactive:
		velocity.y += gravity
		velocity = move_and_slide(velocity, Vector2.UP)
	match(state):
		states.stun:
			velocity.x = lerp(velocity.x, 0, 0.02)
			stuntimer -= 0.5
			if is_on_floor():
				velocity.y = -speed * 2
				$animator.scale = Vector2(0.56 + 0.1, 0.56 - 0.1)
			if is_on_wall():
				velocity.x = -flungvelocity / 2
				$animator.scale = Vector2(0.56 - 0.4, 0.56 + 0.4)
				global.playsound(position, "res://assets/sound/sfx/sfx_grapple.wav")
				#$AnimationPlayer.play("squash")
			if stuntimer < 0:
				state = states.normal
				canhurt = true
				animator.play("default")
				$AnimationPlayer.play("New Anim")
		states.scared:
			velocity.x = 0
			animator.play("scared")
			scaredtimer -= 0.3
			if scaredtimer < 0:
				state = states.normal
				animator.play("default")
		states.inactive:
			velocity.x = 0
			velocity.y = 0
			animator.play("default")
			visible = false
		
	
func wander():
	if not $enemyesentials/floorcheck.is_colliding() or $enemyesentials/walldec.is_colliding():
		if is_on_floor():
			direction = !direction
			$animator.flip_h = !$animator.flip_h
			$enemyesentials.scale.x = -$enemyesentials.scale.x
			if !direction:
				numdirection = 1
			if direction:
				numdirection = -1
				
func getscared():
	if $enemyesentials/getscaredr.is_colliding():
		if !state == states.scared:
			$enemyesentials/gasp.play()
			scaredtimer = 60
			velocity.y = -900 / 2.5
			state = states.scared
			$animator.scale = Vector2(0.56 - 0.3, 0.56 + 0.3)
	if $enemyesentials/getscaredl.is_colliding():
		if !state == states.scared:
			direction = !direction
			$enemyesentials/gasp.play()
			$animator.flip_h = !$animator.flip_h
			$enemyesentials.scale.x = -$enemyesentials.scale.x
			if !direction:
				numdirection = 1
			if direction:
				numdirection = -1
			scaredtimer = 60
			velocity.y = -900 / 2.5
			state = states.scared
			$animator.scale = Vector2(0.56 - 0.3, 0.56 + 0.3)
#	pass



