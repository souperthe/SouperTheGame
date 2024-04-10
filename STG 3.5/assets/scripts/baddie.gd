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

var state = states.normal

var health = 1
var stuntimer = 60
var scaredtimer = 60
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
	hurteffect()
	hurteffect()
	#hurteffect()
	punchsound()
	bangeffect()
	if canhurt:
		if !state == states.stun:
			if health > 1:
				state = states.stun
				velocity.y = -900
				velocity.x = yadda 
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
		#self.rotation = normal.angle() + deg2rad(90)
	else:
		animator.rotation = 0
	
func dead(p):
	global.addcombo()
	bangeffect()
	#global.playsound(position, "res://assets/sound/owsfx.tres")
	if escape:
		global.escaperoom.append(global.targetRoom2 + name)
	if !escape:
		global.baddieroom.append(global.targetRoom2 + name)
	createdead1(p)
	queue_free()

func createdead1(velocityx):
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.velocity.y = -1000
	ghost.velocity.x = velocityx
	ghost.spinamount = rand_range(-10,10)
	randomize()
	ghost.sprite.texture = load(deadsprite)
	ghost.sprite.flip_h = animator.flip_h
	ghost.sprite.scale.x = animator.scale.x
	ghost.sprite.scale.y = animator.scale.y
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
	$CollisionShape2D.disabled = state == states.inactive
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
			if stuntimer < 0:
				state = states.normal
				animator.play("default")
				$AnimationPlayer.play("New Anim")
		states.scared:
			velocity.x = 0
			animator.play("scared")
			scaredtimer -= 0.5
			if scaredtimer < 0:
				state = states.normal
				animator.play("default")
		states.inactive:
			velocity = Vector2(0,0)
			animator.play("stun")
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
#	pass



