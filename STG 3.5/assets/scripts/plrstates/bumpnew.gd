extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	animation_player.play("bump")
	player.sfxbump.play()
	player.velocity.y = -335
	player.attacksfx.stop()
	pass # Replace with function body.

func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if !player.face:
		player.velocity.x = -335
	if player.face:
		player.velocity.x = 335
	if player.animatonframes > 10:
		state_machine.transition_to("Idle")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
