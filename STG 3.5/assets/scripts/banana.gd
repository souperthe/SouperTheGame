extends KinematicBody2D

var gravity = 35
var velocity := Vector2.ZERO
var slipped = false
export (bool) var candie
export (bool) var painintheass
var player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.othersroom.has(global.targetRoom2 + name)):
		queue_free()
	pass # Replace with function body.
	
func _physics_process(_delta):
	if global.oldtodmode:
		queue_free()
	if slipped:
		$sprite.rotation_degrees = 8
	_physic()
	

func _physic():
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0, 0.5)
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
func kill():
	global.othersroom.append(global.targetRoom2 + name)
	slipped = true
	#velocity.y -= 900
	$CollisionShape2D.queue_free()
	$plrcheck/CollisionShape2D.queue_free()
	yield(get_tree().create_timer(4.0), "timeout")
	queue_free()
	
	
func _slip():
	if !painintheass:
		player.state.transition_to("peelslip")
	if painintheass:
		player.state.transition_to("peelslipbounce")
	if candie:
		kill()
	$slip.play()	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_plrcheck_body_entered(body):
	if body is Player:
		player = body
		_slip()
	pass # Replace with function body.
