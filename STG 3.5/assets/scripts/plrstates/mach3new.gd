extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)

var speed = 1050
var started = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.mach4.play()
	player.animation2.play("startmach3")
	animation_player.play("mach3")
	player.candoor = 1
	player.velocity.y = 0
	speed = 2050
	player.pmachbox.disabled = false
	player.machbox.disabled = false
	player.emachbox.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	if player.is_on_floor():
		player.speedpart.emitting = true
	if !player.is_on_floor():
		player.speedpart.emitting = false
	speed += 4
	player.trail()
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	if !player.face and player.is_on_floor():
		if player.velocity.x > 2050:
			state_machine.transition_to("Mach3")
		if Inputs.key_left:
			state_machine.transition_to("MachTurn", {one = true})
		player.velocity.x = lerp(player.velocity.x, speed, player.acceleration * delta)
	if player.face and player.is_on_floor():
		if player.velocity.x < -2050:
			state_machine.transition_to("Mach3")
		if Inputs.key_right:
			state_machine.transition_to("MachTurn", {one = true})
		player.velocity.x = lerp(player.velocity.x, -speed, player.acceleration * delta)
	if player.is_on_floor() and Inputs.just_key_jump:
		state_machine.transition_to("mach_jump", {do_jump = true})
	if player.is_on_wall():
		state_machine.transition_to("bumpwall")
		#player.hitwall.play()
		player.mach4.stop()
	if player.is_on_floor() and Inputs.just_key_up:
		state_machine.transition_to("sjump_prep")
		player.mach4.stop()
	if !player.is_on_floor() and Inputs.just_key_down:
		state_machine.transition_to("fallpound_start")
		player.mach4.stop()
	pass
	
func exit() -> void:
	player.speedpart.emitting = false
	player.pmachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
	player.mach4.stop()
	pass
