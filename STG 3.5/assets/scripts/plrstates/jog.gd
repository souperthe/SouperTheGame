extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 0


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	animation_player.play("jog")
	speed = 0
	pass # Replace with function body.

func physics_update(delta: float) -> void:
	if !Inputs.key_dash:
		state_machine.transition_to("Idle")
	if player.is_on_floor():
		speed = lerp(speed, 850, 0.07)
		if Inputs.just_key_jump:
			player.velocity.y = -player.jump_impulse
			player.jumpsfx.play()
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if player.is_on_floor() and Inputs.key_down:
		state_machine.transition_to("crouchsliding")
	if player.is_on_floor() and player.is_on_wall():
		state_machine.transition_to("bumpwall")
		player.hitwall.play()
		#player.mach4.stop()
		player.hurteffect()
	if !player.is_on_floor() and player.is_on_wall():
		state_machine.transition_to("grapple")
	if !player.is_on_floor() and Inputs.just_key_down:
		state_machine.transition_to("diving")
		player.mach3.stop()
	if speed > 800:
		state_machine.transition_to("Mach2")
	if !player.face:
		player.velocity.x = speed
	if player.face:
		player.velocity.x = -speed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
