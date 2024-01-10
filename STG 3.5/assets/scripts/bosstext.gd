extends KinematicBody2D
class_name Boss


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rang = RandomNumberGenerator.new()
var random
var speed = 450
var speedrun = 1050
var speedrun2 = 2050
var speedrun3 = 2050
onready var animator = $animation
var bosshealth = 10
var enemy2 = preload("res://assets/objects/banana.tscn")
var jump_impulse = 670
var attack_impulse = 335
var gravity = 1600
var velocity := Vector2.DOWN
onready var statemachine = $StateMachine
var canfight = false
onready var punchurt = $hurtpart/CollisionShape2D
var grounded
var onwall
var onceiling 
var stunned = 100
var stunned2 = 50

enum {idle,attack,bump,hurt,stun,decide,cutscene}
var state = idle

var face = false

# Called when the node enters the scene tree for the first time.
func _ready():
	punchurt.disabled = true
	faceplayer()
	pass # Replace with function body.
	
func faceplayer():
	face = !position.x < objplayer.position.x
	
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
	
	


func _process(delta):
	if bosshealth < 0:
		bosshealth += abs(bosshealth)
	var my_random_number2 = rang.randi_range(1, 4)
	random = my_random_number2
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP, true)
	grounded = is_on_floor()
	onwall = is_on_wall()
	onceiling = is_on_ceiling()
	animator.flip_h = face
	statemachine()
	
	
func stun():
	state = stun
	stunned2 = 50
	
	
	
func kill(what):
	if state == stun:
		velocity.x = what
		velocity.y -= 900
		state = hurt
		bosshealth -= 1
		faceplayer()
		deadsound()
		stunned = 100
		if bosshealth == 0:
			createdead1(velocity.x, velocity.x / 200)
			queue_free()
	
	
func trail():
	var dashtrail = preload("res://assets/objects/playerdashtrail.tscn")
	var ghost: AnimatedSprite = dashtrail.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.playing = false
	ghost.flip_h = animator.flip_h
	ghost.global_position = global_position
	#ghost.position.y += -4.301
	ghost.frames = animator.frames
	ghost.z_index = self.z_index - 1
	ghost.animation = animator.animation
	ghost.frame = animator.frame
	ghost.rotation = animator.rotation
	ghost.scale.x = animator.scale.x
	ghost.scale.y = animator.scale.y
	
func statemachine():
	if objplayer.bosshealth == 0:
		state = cutscene
		animator.play("awesome")
		velocity.x = lerp(velocity.x, 0, 0.05)
	punchurt.disabled = !state == attack
	match(state):
		idle:
			faceplayer()
			animator.play("idle")
			if !objplayer.currentstate == ("cutscene"):
				state = decide
		attack:
			var speed = 950
			trail()
			if animator.animation == ("punch"):
				if face:
					velocity.x = -speed
				if !face:
					velocity.x = speed
				if is_on_wall():
					velocity.x = -velocity.x / 2
					velocity.y -= 500
					animator.play("bump")
					stun()
			if animator.animation == ("fp_start"):
				velocity.x = 0
				position.x = lerp(position.x, objplayer.position.x, 0.1)
				if is_on_floor():
					animator.play("sjump_start")
					stun()
		hurt:
			animator.play("hurt")
			stunned -= 1
			velocity.x = lerp(velocity.x, 0, 0.02)
			if stunned < 0:
				state = idle
			if is_on_floor():
				velocity.y -= 500
			if is_on_wall():
				velocity.x = -velocity.x
		stun:
			velocity.x = lerp(velocity.x, 0, 0.02)
			stunned2 -= 1
			if stunned2 < 0:
				state = idle
		decide:
			if random == 1:
				state = attack
				animator.play("punch")
			if random == 2:
				state = attack
				animator.play("fp_start")
				velocity.y = -900
			if random == 3:
				if !state == stun:
					createbanana()
				animator.play("gunfire")
				stun()
			if random == 4:
				if !state == stun:
					createbombs()
				animator.play("collect")
				stun()
				
				
func createbanana():
	var dashtrail = preload("res://assets/objects/bulletenemy.tscn")
	var ghost: KinematicBody2D = dashtrail.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	var speed = 980
	if face:
		ghost.velocity.x = -speed
	if !face:
		ghost.velocity.x = speed
		
		
func createbombs():
	var dashtrail = preload("res://assets/objects/bomb.tscn")
	var ghost: KinematicBody2D = dashtrail.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.velocity.y = 500
	var speed = 980
	if face:
		ghost.velocity.x = -speed
	if !face:
		ghost.velocity.x = speed
			
func createdead1(velocityx, rotatespeed):
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.sprite.flip_h = !position.x < objplayer.position.x
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.velocity.y = -900
	ghost.velocity.x = velocityx
	ghost.spinamount = rotatespeed
	ghost.sprite.texture = load("res://assets/sprites/player_souper/souperanim_0069.png")
	ghost.sprite.scale.x = 0.56
	ghost.sprite.scale.y = 0.56
	
			


