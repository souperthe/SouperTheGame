extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.velocity.y = -player.jump_impulse
	player.attacksfx.play()
	animation_player.play("tumble")
	player.attackbox.disabled = false
	player.eattackbox.disabled = false
	player.pmachbox.disabled = false
	player.machbox.disabled = false
	player.emachbox.disabled = false
	pass # Replace with function body.
	
	
func physics_update(delta: float) -> void:
	player.speedpart.emitting = false
	player.trail()
	if Input.is_action_just_pressed(player.input_attack):
		if Input.is_action_pressed(player.input_up):
			state_machine.transition_to("upperkick")
	if !player.is_on_floor() and Input.is_action_just_pressed(player.input_down):
		state_machine.transition_to("diving")
	if player.is_on_wall():
		if player.playercharacter == "SM":
			state_machine.transition_to("grapple")
		if player.playercharacter == "S":
			state_machine.transition_to("bump")
	if Input.is_action_just_pressed(player.input_run):
		if player.playercharacter == "S":
			state_machine.transition_to("Mach3")
			player.sfxinstamach.play()
			player.doflash()
		if player.playercharacter == "SM":
			state_machine.transition_to("Mach3")
			player.sfxinstamach.play()
			player.doflash()
	#if Input.is_action_just_pressed(player.input_jump):
		#state_machine.transition_to("mach_jump", {do_jump = true})
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if !player.face:
		player.velocity.x = player.attack_impulse * 3
		if Input.is_action_just_pressed(player.input_left):
			player.attackbox.disabled = true
			player.eattackbox.disabled = true
			state_machine.transition_to("Idle")
			player.get_input_direction()
			player.attacksfx.stop()
			player.sjumpentersfx.play()
			player.velocity.y = 0
	if player.face:
		player.velocity.x = -player.attack_impulse * 3
		if Input.is_action_just_pressed(player.input_right):
			player.velocity.y = 0
			player.attackbox.disabled = true
			player.eattackbox.disabled = true
			state_machine.transition_to("Idle")
			player.get_input_direction()
			player.attacksfx.stop()
			player.sjumpentersfx.play()
	if player.animatonframes > 8:
		player.attackbox.disabled = true
		player.eattackbox.disabled = true
		if not is_zero_approx(player.get_input_direction()):
			if !player.is_on_floor():
				state_machine.transition_to("mach_jump")
			if player.is_on_floor():
				state_machine.transition_to("Mach2")
		if is_zero_approx(player.get_input_direction()):
			state_machine.transition_to("Idle")
	if player.is_on_floor():
				state_machine.transition_to("Mach2")
		
		
func exit() -> void:
	player.attackbox.disabled = true
	player.eattackbox.disabled = true
	player.speedpart.emitting = false
	player.pmachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
