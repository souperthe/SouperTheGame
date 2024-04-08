extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
var laststate
var lastxvel
var lastyvel
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	lastxvel = 0
	animation_player.play("gunfire")
	animation_player.frame = 0
	if !player.currentstate == ("gunfire"):
		laststate = player.currentstate
		if player.currentstate == ("mach_jump"):
			lastxvel = player.velocity.x
			lastyvel = player.velocity.y
	player.sfxfire.play()
	createbullet()
	#if !player.is_on_floor():
		##player.velocity.y = -player.jump_impulse / 2
	pass # Replace with function body.



func physics_update(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0, player.air_friction * delta)
	animation_player.play("gunfire")
	#player.velocity.y += player.gravity * delta
	#player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if player.animatonframes > 4:
		state_machine.transition_to(str(laststate))
		if lastxvel != 0:
			player.velocity.x = lastxvel
			player.velocity.y = lastyvel
	pass
	
	
func createbullet():
	var whiteflash = preload("res://assets/objects/bullet.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = player.position.x
	ghost.position.y = player.position.y
	var bulletspeed = 800
	ghost.sprite.flip_h = player.animator.flip_h
	if !player.face:
		ghost.velocity.x = bulletspeed
	if player.face:
		ghost.velocity.x = -bulletspeed
