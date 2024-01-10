extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var grav = 35
var velocity := Vector2.ZERO
var snap = 30
var snap_vector = Vector2.DOWN * snap

var anchorY = 2
var frequency = 0.1
var amplitude = 5
var timer = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = 0
	pass # Replace with function body.


func _process(_delta):
	$Gun.position.y = anchorY + sin(timer*frequency)*amplitude
	timer += 0.5
	if $detectg.overlaps_body(objplayer):
		if !objplayer.gun:
			playcock()
			objplayer.gun = true
			queue_free()
	pass
	
func _physics_process(_delta):
	velocity.y += grav
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP)
	
func playcock():
	var whiteflash = preload("res://assets/objects/cocking.tscn")
	var ghost: AudioStreamPlayer2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.play()
	pass
