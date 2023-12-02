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
onready var col = $collison
onready var check = $hitcheck/check
onready var tiltcheck = $tilcheck
onready var animator = $AnimatedSprite
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.baddieroom.has(global.targetRoom2 + name)):
		queue_free()
	pass # Replace with function body.


func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.y += gravity
	var my_random_number2 = rang.randi_range(1, 6)
	random = my_random_number2

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
	
func hitpart():
	$hitpart1.emitting = true
	$hitpart2.emitting = true
	$hitpart3.emitting = true
	
func kill():
	#col.queue_free()
	$anim.play("hurt")
	deadsound()
	global.addcombo()
	hitpart()
	velocity.y -= 900
	dead = true
	global.baddieroom.append(global.targetRoom2 + name)
	#yield(get_tree().create_timer(4.0), "timeout")
	#queue_free()
	
func _move():
	velocity.x = -speed if is_movingleft else speed
		

	
	


func _on_hitcheck_area_entered(area):
	pass # Replace with function body.
