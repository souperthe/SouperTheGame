extends PlayerState

export (NodePath) var _animation_player
export (NodePath) var _stepsound
onready var animation_player:AnimatedSprite = get_node(_animation_player)
onready var stepsound:AudioStreamPlayer2D = get_node(_stepsound)


func enter(_msg := {}) -> void:
	player.candoor = 1
	player.pmachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
	player.mmachbox.disabled = true
	player.mattackbox.disabled = true
	player.disabletitlt = false
	#player.canhurt = true
	

func physics_update(_delta: float) -> void:
	if !player.canuncrouch:
		state_machine.transition_to("crouch")
	if !animation_player.animation == "land" and !animation_player.animation == "crouchdone":
		if player.gun:
			animation_player.play("idlegun")
		if not player.gun:
			if global.combo == 0:
					if global.panic:
							animation_player.play("idlepanic")
					if !global.panic:
						animation_player.play("idle")
			if !global.combo == 0:
				animation_player.play("angryidle")
	if animation_player.animation == "land":
		if player.animatonframes > 4:
			animation_player.play("idle")
	if animation_player.animation == "crouchdone":
		if player.animatonframes > 4:
			animation_player.play("idle")
	if player.form:
			player.formexit.play()
			player.form = false
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	#player.velocity.x = lerp(player.velocity.x, 0, player.friction * delta)
	player.velocity.x = 0
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	if Input.is_action_just_pressed(player.input_down):
		state_machine.transition_to("crouch")
	
	if Input.is_action_just_pressed(player.input_noclip) and OS.is_debug_build():
		state_machine.transition_to("Noclip")
	if player.gun and Input.is_action_just_pressed(player.input_shoot):
		state_machine.transition_to("gunfire")
	if Input.is_action_just_pressed(player.input_jump):
		state_machine.transition_to("Air", {do_jump = true})
	elif not is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Run")
	if player.ladder:
		if Input.is_action_just_pressed(player.input_up) or Input.is_action_just_pressed(player.input_down):
			state_machine.transition_to("Ladder")
	if Input.is_action_just_pressed(player.input_run):
		state_machine.transition_to("MachPrep")
	if Input.is_action_just_pressed(player.input_attack):
		if Input.is_action_pressed(player.input_up):
			state_machine.transition_to("upperkick")
			player.velocity.y = -player.jump_impulse * 1.3
		if !Input.is_action_pressed(player.input_up):
			state_machine.transition_to("Attack")

