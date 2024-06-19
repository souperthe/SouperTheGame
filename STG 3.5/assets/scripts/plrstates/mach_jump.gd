extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(msg := {}) -> void:
	player.machbox.disabled = false
	player.emachbox.disabled = false
	player.mach3.stop()
	player.sfxspinng.play()
	animation_player.play("spin2")
	if msg.has("do_jump"):
		player.jumpsfx.play()
		player.velocity.y = -player.jump_impulse
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func physics_update(delta: float) -> void:
	player.trail()
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if player.gun and Inputs.just_key_shoot:
		state_machine.transition_to("gunfire")
	if player.is_on_floor():
		state_machine.transition_to("Mach2")
	if Inputs.just_key_attack:
		if Inputs.key_up:
			state_machine.transition_to("upperkick")
			player.velocity.y += -4 * 60
			player.mach3.stop()
			player.machbox.disabled = true
			player.emachbox.disabled = true
		if !Inputs.key_up:
			state_machine.transition_to("tumble")
			player.mach3.stop()
			player.machbox.disabled = true
			player.emachbox.disabled = true
			player.velocity.y = 0
	if !player.is_on_floor() and Inputs.just_key_down:
		state_machine.transition_to("diving")
		player.mach3.stop()
		player.machbox.disabled = true
		player.emachbox.disabled = true
	if player.is_on_wall():
		player.machbox.disabled = true
		player.emachbox.disabled = true
		state_machine.transition_to("grapple")
func exit():
	player.sfxspinng.stop()
