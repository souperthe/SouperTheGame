extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	animation_player.play("grapplewall")
	player.sfxgrapple.play()
	player.mach3.stop()
	#player.velocity.x = 0
	player.velocity.y = 0
	player.machbox.disabled = true
	player.emachbox.disabled = true
	if !player.face:
		player.velocity.x = player.speedrun2
	if player.face:
		player.velocity.x = -player.speedrun2
	
func physics_update(delta: float) -> void:
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	if !player.is_on_wall():
		state_machine.transition_to("Idle")
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	player.velocity.y += 200 * delta
	if Input.is_action_just_pressed(player.input_jump):
		dojump()
	
		
		
		
func dojump():
	if !player.face:
		player.velocity.x = 0
		player.animator.flip_h = true
		player.velocity.x = -player.speedrun
	if player.face:
		player.velocity.x = 0
		player.animator.flip_h = false
		player.velocity.x = player.speedrun
	player.face = !player.face
	state_machine.transition_to("mach_jump", {do_jump = true})
	

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
