extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func enter(msg := {}) -> void:
	if !animation_player.animation == ("crouchjump"):
		animation_player.play("crouchfall")
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_impulse / 1.5
		player.jumpsfx.play()
		player.candoor = 0
		animation_player.play("crouchjump")


func physics_update(delta: float) -> void:
	if player.is_on_floor():
		state_machine.transition_to("crouch")
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed / 2, player.acceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.air_friction * delta)
	if animation_player.animation == ("crouchjump"):
		if player.animatonframes  > 7:
				animation_player.play("crouchfall")
#func _process(delta):
#	pass
