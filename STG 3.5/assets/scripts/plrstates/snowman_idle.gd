extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var moving = 0
var doublejumped = false


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.velocity.x = 0
	animation_player.play("snowman_idle")
	if !player.form:
		player.formenter.play()
	player.form = true
func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta
	walk()
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	player.velocity.x = lerp(player.velocity.x, moving, 0.02)
	animation_player.speed_scale = abs(player.velocity.x) * 1 * _delta
	if Inputs.just_key_jump:
		if player.is_on_floor():
			player.jumpsfx.play()
			player.velocity.y = -520
	if !player.is_on_floor():
		if Inputs.just_key_jump:
			if doublejumped == true:
				player.jumpsfx.play()
				player.velocity.y = -player.jump_impulse


func walk():
	player.get_input_direction()
	if Inputs.key_left:
		animation_player.play("snowman_move")
		moving = -player.speed
	if Inputs.key_right:
		animation_player.play("snowman_move")
		moving = player.speed
	elif is_zero_approx(player.get_input_direction()):
		moving = 0
		animation_player.play("snowman_idle")
		
func exit() -> void:
	animation_player.speed_scale = 1
	if player.form:
		player.formexit.play()
	player.form = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
