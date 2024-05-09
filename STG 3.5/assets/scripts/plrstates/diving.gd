extends PlayerState

var lastxvel
var laststate
var speed
export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
func enter(_msg := {}) -> void:
	animation_player.play("dive")
	player.sjumpentersfx.play()
	player.velocity.y = 100 * 7.5
	#player.velocity.y = -player.jump_impulse
	#player.sfxkick.play()
	player.mattackbox.disabled = false
	if !player.currentstate == ("diving"):
		laststate = player.currentstate
		lastxvel = player.velocity.x
	speed = abs(player.velocity.x)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func physics_update(_delta: float) -> void:
	if player.currentstate == "diving":
		player.machbox.disabled = false
		player.emachbox.disabled = false
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	#player.velocity.x * 1.1
	player.velocity.y += 1
	player.trail()
	#player.velocity.y = abs(lastxvel / 1.2)
	#player.velocity.y = abs(lastxvel / 1.2)
	if player.face:
		player.velocity.x = -speed
	if !player.face:
		player.velocity.x = speed
	if player.is_on_wall():
		player.goofysound()
		#player.face = !player.face
		state_machine.transition_to("bump")
		player.machbox.disabled = true
		player.emachbox.disabled = true
	if player.is_on_floor():
		state_machine.transition_to("crouchsliding")
	if Inputs.just_key_jump:
		player.attacksfx.play()
		player.doflash()
		player.change.play()
		player.velocity.y = -100 * 12
		player.machbox.disabled = true
		player.emachbox.disabled = true
		state_machine.transition_to("fallpound_fall")
		
func exit():
	player.machbox.disabled = true
	player.emachbox.disabled = true
