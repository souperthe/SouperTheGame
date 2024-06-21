extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
var sound_has_played = false
# Declare member variables here. Examples:
var cango = 0
var charge = 0
var charged = false
# var b = "text"

func enter(_msg := {}) -> void:
	animation_player.play("prep2")
	animation_player.speed_scale = 0
	player.machprep.play()
	player.candoor = 0
	sound_has_played = false
	charged = false
	player.velocity.y = 0
	charge = 0


# Called when the node enters the scene tree for the first time.
func physics_update(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0, player.air_friction * delta)
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	player.velocity.y += player.gravity * delta
	if charge < 50:
		if charge > 45:
			if !charged:
				player.change.play()
				player.doflash()
				charged = true
				animation_player.speed_scale = 0
				animation_player.frame = 0
		charge += 50 * delta
		if !charged:
			animation_player.speed_scale = charge / 15
	if charge > 45:
		if !Inputs.key_dash:
			state_machine.transition_to("Mach2")
			animation_player.speed_scale = 1
			player.attacksfx.play()
			#state_machine.transition_to("Mach3")
	else:
		if !Inputs.key_dash:
			#player.attacksfx.play()
			state_machine.transition_to("oldturn")
			animation_player.speed_scale = 1
			#state_machine.transition_to("Mach2")
			
		
	#if timer.timeout():
		#state_machine.transition_to("Noclip")

func exit() -> void:
	animation_player.speed_scale = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


