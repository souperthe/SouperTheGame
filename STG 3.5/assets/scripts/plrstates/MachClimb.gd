extends PlayerState


export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

	
func enter(_msg := {}) -> void:
	animation_player.play("placeholder")
	player.velocity.y = -500
	
func physics_update(_delta: float) -> void:
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	if Inputs.just_key_jump:
		state_machine.transition_to("Air", {do_jump = true})
		player.mach3.stop()
		if !player.face:
			player.velocity.x = -player.jump_impulse
		if player.face:
			player.velocity.x = player.jump_impulse
	if !player.is_on_wall() and !player.is_on_floor():
		state_machine.transition_to("Air")
		player.mach3.stop()
	if player.is_on_wall() and player.is_on_floor():
		player.velocity.y += -3050



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if !player.is_on_wall() and !player.is_on_floor():
		#state_machine.transition_to("Air")
		#player.mach3.stop()
#	pass
