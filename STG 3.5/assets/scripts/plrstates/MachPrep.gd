extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
var sound_has_played = false
# Declare member variables here. Examples:
var cango = 0
# var b = "text"

func enter(_msg := {}) -> void:
	animation_player.play("prep1")
	player.machprep.play()
	player.candoor = 0
	sound_has_played = false
	player.velocity.y = 0


# Called when the node enters the scene tree for the first time.
func physics_update(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0, player.air_friction * delta)
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	player.velocity.y += player.gravity * delta
	if player.cango and sound_has_played:
		if Input.is_action_just_released(player.input_run):
			state_machine.transition_to("Mach2")
			#state_machine.transition_to("Mach3")
	else:
		if Input.is_action_just_released(player.input_run):
			state_machine.transition_to("MachTurn")
			#state_machine.transition_to("Mach2")
			
		
	#if timer.timeout():
		#state_machine.transition_to("Noclip")
	if player.animatonframes == 2 and !sound_has_played:
		animation_player.play("prep2")
		player.change.play()
		sound_has_played = true
		player.cango = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


