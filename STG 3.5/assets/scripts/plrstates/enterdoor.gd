extends PlayerState


export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	animation_player.play("enterdoor")
	player.candoor = 0
	player.velocity.x = 0
	
func physics_update(delta: float) -> void:
	global.combotimer.paused = true
	if Input.is_action_pressed(player.input_noclip) and OS.is_debug_build():
		state_machine.transition_to("Noclip")
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
