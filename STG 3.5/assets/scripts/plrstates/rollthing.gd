extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 5

func enter(_msg := {}) -> void:
	animation_player.play("hardtumble")
	speed = 700
# Called when the node enters the scene tree for the first time.
func physics_update(delta: float) -> void:
	speed += 50
	player.trail()
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	if player.is_on_wall():
		state_machine.transition_to("Hurt")
		player.hitwall.play()
	if !player.face:
		player.velocity.x = speed
	if player.face:
		player.velocity.x = -speed
