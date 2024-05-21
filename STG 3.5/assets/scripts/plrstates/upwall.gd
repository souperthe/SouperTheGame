extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var realvelocity
var used = 1


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.velocity.y = used * -player.jump_impulse * 2
	animation_player.play("spinjump")
	if !player.face:
		player.velocity.x = -335 * 2
	if player.face:
		player.velocity.x = 335 * 2
	used -= 0.2
	#animation_player.flip_h = !animation_player.flip_h
	#player.face = !player.face
	player.doflash()
	pass # Replace with function body.


func physics_update(delta: float) -> void:
	realvelocity = player.velocity / 60
	#player.get_input_direction()
	player.trail()
	if Inputs.key_down:
		 player.velocity.y += player.gravity * delta * 4
	if !Inputs.key_down:
		 player.velocity.y += player.gravity * delta
	var move = -int(Inputs.key_left) - -int(Inputs.key_right)
	player.velocity.x = lerp(player.velocity.x, move * 8 * 60, 5 * delta)
	#walk()
	if Inputs.just_key_attack:
		player.get_input_direction()
		if Inputs.key_up:
			state_machine.transition_to("upperkick")
			player.velocity.y += -4 * 60
		if !Inputs.key_up:
			state_machine.transition_to("tumble")
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	player.mmachbox.disabled = realvelocity.y > 30
	player.mattackbox.disabled = realvelocity.y > 30
	if player.is_on_floor():
		if Inputs.key_dash:
			if realvelocity.y > 30:
				state_machine.transition_to("Mach3")
				player.doflash()
			if realvelocity.y < 30:
				state_machine.transition_to("Mach2")
			player.get_input_direction()
			player.sfxfoot.play()
			used = 1
		if !Inputs.key_dash:
			used = 1
			player.sfxfoot.play()
			if realvelocity.y < 30:
				if is_zero_approx(player.get_input_direction()):
					animation_player.play("land")
					state_machine.transition_to("Idle")
				else:
					animation_player.play("landwalk")
					state_machine.transition_to("Run")
			if realvelocity.y > 30:
				player.poundpart()
				player.fpfallsfx.stop()
				player.hitwall.play()
				player.step.play()
				player.velocity.y = -player.jump_impulse
				state_machine.transition_to("Air")
				player.machbox.disabled = true
				player.emachbox.disabled = true
	pass
	
#func walk():
	#var amount = 0.
