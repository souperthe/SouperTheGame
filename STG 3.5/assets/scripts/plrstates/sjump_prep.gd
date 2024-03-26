extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
var ready = 0
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	animation_player.play("sjump_start")
	player.sjumpentersfx.play()
	ready = 0
	player.velocity.y = 0
	player.velocity.x = 0
	player.disabletitlt = true


func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	player.velocity.x = lerp(player.velocity.x, 0, player.friction * delta)
	if Inputs.key_left:
		player.velocity.x = -225
		if player.is_on_floor():
			player.velocity.y = -player.jump_impulse / 3
			if !player.sfxfoot.playing:
				player.sfxfoot.play()
	if Inputs.key_right:
		player.velocity.x = 225
		if player.is_on_floor():
			player.velocity.y = -player.jump_impulse / 3
			if !player.sfxfoot.playing:
				player.sfxfoot.play()
	if not Inputs.key_up and ready == 1:
		state_machine.transition_to("sjump_start")
	#if not Inputs.key_up and ready == 1:
		#state_machine.transition_to("Idle")
	if animation_player.animation == ("sjump_start"):
		if player.animatonframes > 3:
			ready = 1
			animation_player.play("sjump_ready")
			
		#player.change.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
