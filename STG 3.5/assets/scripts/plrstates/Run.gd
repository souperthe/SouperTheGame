extends PlayerState


export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
var canjump = true
var sfxnothasplayed = true




func enter(_msg := {}) -> void:
	player.candoor = 1
	player.canhurt = true
	pass
	

func physics_update(delta: float) -> void:
	if player.gun and Input.is_action_just_pressed(player.input_shoot):
		state_machine.transition_to("gunfire")
	if animation_player.animation == "move" or animation_player.animation == "walkonwall":
		footstepsfx()
	#if not player.is_on_floor():
		#player.cayatotime.start()
		#state_machine.transition_to("Air")
		#pass
	
	if Input.is_action_just_pressed(player.input_down):
		state_machine.transition_to("crouch")
	if animation_player.animation == "landwalk":
		if player.animatonframes > 3:
			animation_player.play("move")
	if !animation_player.animation == "landwalk":
		if not player.is_on_wall():
			animation_player.play("move")
		if player.is_on_wall():
			animation_player.play("walkonwall")
	if not is_zero_approx(player.get_input_direction()):
		#player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed, player.acceleration * delta)
		walk()
	if !player.is_on_floor():
		player.velocity.y += player.gravity * delta
	#player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	var was_on_floor = player.is_on_floor()
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	var just_left_ledge = was_on_floor and not player.is_on_floor() and player.velocity.y >= 0
	if just_left_ledge:
		player.cayatotime.start()
	if !player.is_on_floor() and player.cayatotime.time_left == 0.0:
		state_machine.transition_to("Air")
	
	if Input.is_action_just_pressed(player.input_run):
		state_machine.transition_to("MachPrep")
	
	if Input.is_action_just_pressed(player.input_jump):
		if canjump:
			state_machine.transition_to("Air", {do_jump = true})
			pass
			
	if Input.is_action_just_pressed(player.input_attack):
		state_machine.transition_to("Attack")
	elif is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Idle")
		
	
		
func coyatoTime():
	yield(get_tree().create_timer(.2), "timeout")
	canjump = false
	pass
	
func walk():
	if Input.is_action_pressed(player.input_left):
		player.velocity.x = -player.speed
	if Input.is_action_pressed(player.input_right):
		player.velocity.x = player.speed
	
	
	
func footstepsfx():
	#print(sfxnothasplayed)
	if player.animatonframes == 2 or player.animatonframes == 6:
		if !player.sfxfoot.playing:
			player.sfxfoot.play()
