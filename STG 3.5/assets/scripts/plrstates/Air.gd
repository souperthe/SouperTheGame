extends PlayerState


export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
var notdropkick = true
var fallfast = false



func enter(msg := {}) -> void:
	notdropkick = true
	fallfast = false
	animation_player.play("fall")
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_impulse
		player.jumpsfx.play()
		player.candoor = 0
		animation_player.play("jump")
		#animation_player.play("idle")


func physics_update(delta: float) -> void:
	if player.gun and Inputs.just_key_shoot:
		state_machine.transition_to("gunfire")
		animation_player.play("gunfire")
	if Inputs.just_key_attack:
		if Inputs.key_up:
			state_machine.transition_to("upperkick")
			player.velocity.y += -4 * 60
		if !Inputs.key_up:
			state_machine.transition_to("tumble")
	if !Inputs.key_jump:
		if !fallfast:
			fallfast = true
			if player.velocity.y < -10:
				player.velocity.y = 10
	if player.ladder:
		if Inputs.key_up or Inputs.key_down:
			state_machine.transition_to("Ladder")
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed, player.acceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.air_friction * delta)
	if !player.canuncrouch:
		state_machine.transition_to("crouch")
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if animation_player.animation == ("jump"):
		if player.animatonframes == 10:
				animation_player.play("fall")
	else:
		if !Inputs.just_key_attack:
			animation_player.play("fall")
		
	
	if Inputs.just_key_down:
		state_machine.transition_to("fallpound_start")
		
	
	if player.is_on_floor():
		player.sfxfoot.play()
		if is_zero_approx(player.get_input_direction()):
			animation_player.play("land")
			state_machine.transition_to("Idle")
		else:
			animation_player.play("landwalk")
			state_machine.transition_to("Run")
