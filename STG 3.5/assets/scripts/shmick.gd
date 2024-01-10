extends KinematicBody2D

export (String) var info

var snap = 30
var gravity = 1600
var snap_vector = Vector2.DOWN * snap if not is_on_floor() else Vector2.ZERO
var velocity := Vector2.DOWN
var face = false
onready var animator = $AnimatedSprite
enum {idle,dead}
var state = idle
var rotatespeed = 2
var rang = RandomNumberGenerator.new()
var random
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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

func faceplayer():
	face = !position.x < objplayer.position.x

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("default")
	pass # Replace with function body.
	
func kill(what):
	state = dead
	faceplayer()
	hurteffect()
	global.addcombo()
	$AnimationPlayer.play("die")
	$speech.read("weiner willy fuck")
	velocity.y -= 900
	velocity.x = what
	rotatespeed = what / 200 
	deadsound()
	
func _physics_process(delta):
	$dialog.text = info
	if global.panic:
		info = "GET OUT RIGHT NOW!!!!!"
	var my_random_number2 = rang.randi_range(1, 4)
	random = my_random_number2
	animator.flip_h = face
	if !is_on_floor():
		velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP)
	match(state):
		idle:
			faceplayer()
		dead:
			$AnimatedSprite.rotation_degrees += rotatespeed
			$CollisionShape2D.disabled = true
			$AnimatedSprite.play("die")
			$speech.read("")
			
func hurteffect():
	var whiteflash = preload("res://assets/objects/hurtpartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.amount = 500


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_playerdetect_body_exited(body):
	if body is Player:
		$dialog.active = false
		$speech.read("")
	pass # Replace with function body.


func _on_playerdetect_body_entered(body):
	if body is Player and state == idle:
		$dialog.active = true
		$speech.read(info)
	pass # Replace with function body.
