extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.velocity.y = -player.jump_impulse
	player.jumpsfx.play()
	animation_player.play("fp_start")

func physics_update(delta: float) -> void:
	if Inputs.just_key_attack:
		state_machine.transition_to("upperkick")
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	#player.velocity.x = lerp(player.velocity.x, 0, 2 * delta)
	if player.animatonframes == 4:
		state_machine.transition_to("fallpound_fall")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
