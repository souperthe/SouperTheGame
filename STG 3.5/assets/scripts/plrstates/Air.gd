extends PlayerState


export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
var notdropkick = true



func enter(msg := {}) -> void:
	notdropkick = true
	animation_player.play("fall")
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_impulse
		player.jumpsfx.play()
		player.candoor = 0
		animation_player.play("jump")
		#animation_player.play("idle")


func physics_update(delta: float) -> void:
	if player.gun and Input.is_action_just_pressed(player.input_shoot):
		state_machine.transition_to("gunfire")
		animation_player.play("gunfire")
	if Input.is_action_just_pressed(player.input_attack):
		state_machine.transition_to("tumble")
	if Input.is_action_just_released(player.input_jump):
		 if player.velocity.y < -100:
			 player.velocity.y = -100
	if Input.is_action_just_pressed(player.input_noclip) and OS.is_debug_build():
		state_machine.transition_to("Noclip")
	if player.ladder:
		if Input.is_action_just_pressed(player.input_up) or Input.is_action_pressed(player.input_down):
			state_machine.transition_to("Ladder")
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed, player.acceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.air_friction * delta)
	
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if animation_player.animation == ("jump"):
		if player.animatonframes == 10:
				animation_player.play("fall")
	else:
		if !Input.is_action_just_pressed(player.input_attack):
			animation_player.play("fall")
		
	
	if Input.is_action_just_pressed(player.input_down):
		state_machine.transition_to("fallpound_start")
	
	if player.is_on_floor():
		player.sfxfoot.play()
		if is_zero_approx(player.get_input_direction()):
			animation_player.play("land")
			state_machine.transition_to("Idle")
		else:
			animation_player.play("landwalk")
			state_machine.transition_to("Run")
