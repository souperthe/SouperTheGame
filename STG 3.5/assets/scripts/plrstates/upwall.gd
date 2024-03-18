extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var realvelocity


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.velocity.y = -player.jump_impulse * 2
	animation_player.play("spinjump")
	if !player.face:
		player.velocity.x = 335 * 2
	if player.face:
		player.velocity.x = -335 * 2
	#animation_player.flip_h = !animation_player.flip_h
	#player.face = !player.face
	player.doflash()
	pass # Replace with function body.


func physics_update(delta: float) -> void:
	realvelocity = player.velocity / 60
	player.get_input_direction()
	player.trail()
	if Input.is_action_pressed(player.input_down):
		 player.velocity.y += player.gravity * delta * 4
	if !Input.is_action_pressed(player.input_down):
		 player.velocity.y += player.gravity * delta
	walk()
	if Input.is_action_just_pressed(player.input_attack):
		player.get_input_direction()
		if Input.is_action_pressed(player.input_up):
			state_machine.transition_to("upperkick")
		if !Input.is_action_pressed(player.input_up):
			state_machine.transition_to("tumble")
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	player.mmachbox.disabled = realvelocity.y > 30
	player.mattackbox.disabled = realvelocity.y > 30
	if player.is_on_floor():
		if Input.is_action_pressed(player.input_run):
			if realvelocity.y > 30:
				state_machine.transition_to("Mach3")
			if realvelocity.y < 30:
				state_machine.transition_to("Mach2")
			player.get_input_direction()
			player.sfxfoot.play()
		if !Input.is_action_pressed(player.input_run):
			player.sfxfoot.play()
			if is_zero_approx(player.get_input_direction()):
				animation_player.play("land")
				state_machine.transition_to("Idle")
			else:
				animation_player.play("landwalk")
				state_machine.transition_to("Run")
	pass
	
func walk():
	var amount = 0.2
	if Input.is_action_pressed(player.input_left):
		player.velocity.x = lerp(player.velocity.x , -player.attack_impulse, amount)
	if Input.is_action_pressed(player.input_right):
		player.velocity.x = lerp(player.velocity.x , player.attack_impulse, amount)
	if !Input.is_action_pressed(player.input_left) and Input.is_action_pressed(player.input_right):
		player.velocity.x = lerp(player.velocity.x , 0, amount)
