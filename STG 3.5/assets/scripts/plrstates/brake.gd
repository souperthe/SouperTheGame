extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	animation_player.play("brake")
	player.machcancel.play()
	player.candoor = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	player.speed3part.emitting = false
	player.speedpart.emitting = false
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	player.velocity.x = lerp(player.velocity.x, 0, 6 * delta)
	if player.animatonframes > 11:
		state_machine.transition_to("Idle")
