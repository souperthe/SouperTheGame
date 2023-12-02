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
	if msg.has("do_jump"):
		player.jumpsfx.play()
		player.velocity.y = -player.jump_impulse
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func physics_update(delta: float) -> void:
	player.trail()
	animation_player.play("spin2")
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if player.gun and Input.is_action_just_pressed(player.input_shoot):
		state_machine.transition_to("gunfire")
	if player.is_on_floor():
		state_machine.transition_to("Mach2")
	if Input.is_action_just_pressed(player.input_attack):
		state_machine.transition_to("tumble")
		player.mach3.stop()
		player.machbox.disabled = true
		player.emachbox.disabled = true
	if !player.is_on_floor() and Input.is_action_just_pressed(player.input_down):
		state_machine.transition_to("fallpound_start")
		player.mach3.stop()
		player.machbox.disabled = true
		player.emachbox.disabled = true
	if player.is_on_wall():
		player.machbox.disabled = true
		player.emachbox.disabled = true
		state_machine.transition_to("grapple")
func exit():
	player.sfxspinng.stop()
