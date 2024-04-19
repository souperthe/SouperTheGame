extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
func enter(_msg := {}) -> void:
	if !player.is_on_floor():
		player.velocity.y += -17 * 60
	if player.is_on_floor():
		player.velocity.y += -15 * 60
	animation_player.play("upperkick")
	player.sjumpentersfx.play()
	player.velocity.y = -player.jump_impulse
	#animation_player.flip_h = false
	player.sfxkick.play()
	player.mattackbox.disabled = false


func physics_update(delta: float) -> void:
	walk()
	player.trail()
	#player.velocity.x = lerp(player.velocity.x, 0, player.friction / 50 * delta)
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	#player.velocity.x = lerp(player.velocity.x, 0, player.friction * delta)
	if !Inputs.key_dash && player.is_on_floor():
		player.mattackbox.disabled = true
		player.sfxfoot.play()
		land()
	if Inputs.key_dash && player.is_on_floor():
		player.sfxfoot.play()
		state_machine.transition_to("Mach2")
		player.get_input_direction()
			
func walk():
	var amount = 0.2
	if Inputs.key_left:
		player.velocity.x = lerp(player.velocity.x , -player.attack_impulse, amount)
	if Inputs.key_right:
		player.velocity.x = lerp(player.velocity.x , player.attack_impulse, amount)
	
func land():
	if is_zero_approx(player.get_input_direction()):
		animation_player.play("land")
		state_machine.transition_to("Idle")
	else:
		animation_player.play("landwalk")
		state_machine.transition_to("Run")
			
			
