extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timertime = 2
var gravity = 35
var velocity := Vector2.ZERO
var rang = RandomNumberGenerator.new()
var random


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("New Anim (2)")
	pass # Replace with function body.


func _process(delta):
	var my_random_number2 = rang.randi_range(1, 6)
	random = my_random_number2
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0, 10 * delta)
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	if $tune.playing:
		$AnimationPlayer.play("New Anim")
		music.musicvolume = -10
	if !$tune.playing:
		music.musicvolume = 2
		$AnimationPlayer.play("New Anim (2)")
	
	
func kill(speed):
	$tune.playing = !$tune.playing
	velocity.y -= 900
	velocity.x = speed
	hurteffect()
	global.resetcombo()
	deadsound()
	
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
	
	
func hurteffect():
	var whiteflash = preload("res://assets/objects/hurtpartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.position.y -= 27
	ghost.amount = 500
