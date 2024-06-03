extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var lastxvel = 0
var canwallclimb = false


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	if !player.currentstate == ("diving"):
		lastxvel = player.velocity.x
	#if player.currentstate != ("grapple"):
		#wallspeed = abs(player.velocity.x)
	animation_player.play("grappleland")
	player.sfxgrapple.play()
	player.mach3.stop()
	#player.velocity.x = 0
	player.velocity.y = player.velocity.x
	player.machbox.disabled = true
	player.emachbox.disabled = true
	if !player.face:
		player.velocity.x = player.speedrun2
	if player.face:
		player.velocity.x = -player.speedrun2
	if player.playercharacter == "SM":
		player.velocity.y = -player.jump_impulse
		if !player.face:
			player.velocity.x = -player.speedrun2
		if player.face:
			player.velocity.x = player.speedrun2
		state_machine.transition_to("upwall")
	
func physics_update(delta: float) -> void:
	if animation_player.animation == "grappleland":
		if player.animatonframes > 5:
			animation_player.play("grapplewall")
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	if !player.is_on_wall():
		if canwallclimb:
			state_machine.transition_to("Mach2")
			player.velocity.y = 0
			#player.position.y -= 64
		if !canwallclimb:
			state_machine.transition_to("Idle")
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if !canwallclimb:
		player.velocity.y += 200 * delta
	if canwallclimb:
		player.velocity.y = -player.speedrun
	if Inputs.just_key_jump:
		dojump()
	
		
		
		
func dojump():
	if !player.face:
		player.velocity.x = 0
		player.animator.flip_h = true
		player.velocity.x = -player.speedrun
	if player.face:
		player.velocity.x = 0
		player.animator.flip_h = false
		player.velocity.x = player.speedrun
	player.face = !player.face
	state_machine.transition_to("mach_jump", {do_jump = true})
	

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
