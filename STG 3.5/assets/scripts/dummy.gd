extends KinematicBody2D

var dead = false
var is_movingleft = true
var gravity = 35
var velocity := Vector2.ZERO
var speed = 200
var deadjump = false
var rang = RandomNumberGenerator.new()
var rang2 = RandomNumberGenerator.new()
var random
var killed = false
var tit = false
onready var col = $collison
onready var check = $hitcheck/check
onready var tiltcheck = $tilcheck
onready var animator = $AnimatedSprite
var rotatespeed = 0.2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.frame = randi() % $AnimatedSprite.frames.get_frame_count("idle")
	if killed:
		kill(0)
	pass # Replace with function body.
	
	
func hitpart():
	$hitpart1.emitting = true
	$hitpart2.emitting = true
	$hitpart3.emitting = true
	yield(get_tree().create_timer(0.5), "timeout")
	$hitpart1.emitting = false
	$hitpart2.emitting = false
	$hitpart3.emitting = false


func _physics_process(_delta):
	var my_random_number2 = rang.randi_range(1, 6)
	random = my_random_number2
	#print(random)
	_move()
	if dead:
		$AnimatedSprite.rotation_degrees += rotatespeed
		
func _on_hitcheck_area_entered(_area):
	#if not dead:
		#kill()
		
	#dead = true
	#queue_free()
	pass
	
func _move():
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	
	

func kill(sdhagdhqwjdawaw):
	$AnimatedSprite.position.y = 0
	col.queue_free()
	$anim.play("hurt")
	deadsound()
	global.resetcombo()
	hitpart()
	velocity.y -= 900
	velocity.x = sdhagdhqwjdawaw
	rotatespeed = sdhagdhqwjdawaw / 200 
	dead = true
	yield(get_tree().create_timer(4.0), "timeout")
	queue_free()
		
func deadsound():
	$hurt7.play()
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
	if self.is_on_floor() and tiltcheck.is_colliding():
		var normal = tiltcheck.get_collision_normal()
		animator.rotation = normal.angle() + deg2rad(90)
		#self.rotation = normal.angle() + deg2rad(90)
	else:
		animator.rotation = 0
		#self.rotation = 0

