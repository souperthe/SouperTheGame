extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)


func enter(_msg := {}) -> void:
	pass
	
	
	
func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	player.velocity.x = 0
	#if Input.is_action_just_pressed(player.input_attack):
		#state_machine.transition_to("tumble")
	if !player.is_on_floor() and Input.is_action_just_pressed(player.input_down):
		state_machine.transition_to("fallpound_start")
	if player.is_on_floor():
		state_machine.transition_to("Mach2", {do_turn = true})
