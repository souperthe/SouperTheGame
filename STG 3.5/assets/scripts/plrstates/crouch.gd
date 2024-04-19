extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	animation_player.play("crouchstart")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	if is_zero_approx(player.get_input_direction()):
		player.velocity.x = 0
		if player.is_on_floor() and !animation_player.animation == ("crouchstart"):
			animation_player.play("crouchidle")
	if not is_zero_approx(player.get_input_direction()):
		#player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed, player.acceleration * delta)
		walk()
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	if animation_player.animation == ("crouchstart"):
		if player.animatonframes > 3:
			animation_player.play("crouchidle")
	if !Inputs.key_down and player.canuncrouch:
		#if !player.uncrouchdetect.is_colliding():
		state_machine.transition_to("Idle")
		animation_player.play("crouchdone")
	if not player.is_on_floor():
		state_machine.transition_to("crouchair")
	if Inputs.just_key_jump and player.canuncrouch:
		state_machine.transition_to("crouchair", {do_jump = true})
		animation_player.play("crouchjump")
#	pass


func walk():
	if player.is_on_floor():
		animation_player.play("crouchwalk")
		footstepsfx()
	if Inputs.key_left:
		player.velocity.x = -player.speed / 2
	if Inputs.key_right:
		player.velocity.x = player.speed / 2
		
func footstepsfx():
	#print(sfxnothasplayed)
	if player.animatonframes == 3:
		if !player.sfxfoot.playing:
			player.sfxfoot.play()
