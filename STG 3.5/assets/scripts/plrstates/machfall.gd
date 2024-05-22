extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)


func enter(_msg := {}) -> void:
	if animation_player.animation == "machturn2":
		animation_player.play("machfall2")
	pass
	
	
	
func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	player.velocity.x = 0
	#if Inputs.just_key_attack:
		#state_machine.transition_to("tumble")
	#if !player.is_on_floor() and Inputs.just_key_down:
		#state_machine.transition_to("fallpound_start")
	if player.is_on_floor():
		state_machine.transition_to("Mach2", {do_turn = true})
		player.face = !player.face
		animation_player.flip_h = !animation_player.flip_h
		
