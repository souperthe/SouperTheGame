extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity := Vector2.DOWN
var go = 500
onready var sprite  = $Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	trail()
	velocity = move_and_slide(velocity, Vector2.UP, true)
	if is_on_wall():
		deadgun()
		queue_free()
	pass


func _on_enemycheck_body_entered(body):
	body.kill(velocity.x)
	#deadgun()
	queue_free()
	pass # Replace with function body.
	
	
func deadgun():
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.velocity.y = -700
	ghost.velocity.x = 0
	ghost.spinamount = 5
	ghost.sprite.texture = load("res://assets/sprites/player_souper/gunbullet.png")
	ghost.sprite.scale.x = 0.56
	ghost.sprite.scale.y = 0.56
	
	
func trail():
	var dashtrail = preload("res://assets/objects/playerdashtrail.tscn")
	var ghost: AnimatedSprite = dashtrail.instance()
	var animator = $Sprite
	roomhandle.currentscene.add_child(ghost)
	ghost.playing = false
	ghost.flip_h = animator.flip_h
	ghost.global_position = global_position
	ghost.scale.x = animator.scale.x
	ghost.scale.y = animator.scale.y
	ghost.z_index = animator.z_index - 1
	#ghost.position.y += -4.301
	ghost.frames = animator.frames
	ghost.animation = animator.animation
	ghost.frame = animator.frame
	ghost.rotation = animator.rotation
	ghost.modulate.r8 = 215
	ghost.modulate.g8 = 138
	ghost.modulate.b8 = 0



func _on_wallcheck_body_entered(_body):
	#if !body is Player:
		#queue_free()
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body is Player:
		body.hurtplayer()
		queue_free()
	pass # Replace with function body.
