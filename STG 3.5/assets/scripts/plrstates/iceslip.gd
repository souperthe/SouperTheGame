extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var a = true


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	a = true
	player.speedpart.emitting = true
	player.velocity.y = 100 * 35
	player.position.y += 1
	#.velocity.y = 0
	animation_player.play("iceslip")
	pass

func physics_update(delta: float) -> void:
	#player.trail()
	if !player.face:
		player.velocity.x = 1050
	if player.face:
		player.velocity.x = -1050
	if player.is_on_floor():
		player.velocity.y = 0
	#player.velocity.x = lerp(player.velocity.x, player.numdirection * player.attack_impulse, 0.1)
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	if player.is_on_wall():
		state_machine.transition_to("peelslip")
		player.velocity.x = -player.numdirection * 300
		player.face = !player.face
	if !player.is_on_floor():
		player.velocity.y = -player.jump_impulse
		#player.velocity.x = player.velocity.x / 2
		state_machine.transition_to("peelslip")
		if a:
			a = false
			player.sfxslip.play()
		player.speedpart.emitting = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
