extends PlayerState


export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.sjumpreleasesfx.play()
	if player.playercharacter == "S":
		player.velocity.y = -980
		animation_player.play("sjump_release")
	if player.playercharacter == "SM":
		player.velocity.y = -980 * 1.7
		animation_player.play("hardtumble")
	player.machbox.disabled = true
	player.emachbox.disabled = true
	player.mmachbox.disabled = false
	player.mattackbox.disabled = false
	
func exit() -> void:
	player.sjumpreleasesfx.stop()
	
	
func physics_update(delta: float) -> void:
	player.trail()
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	player.velocity.x = lerp(player.velocity.x, 0, player.air_friction * delta)
	if player.playercharacter == "S":
		player.velocity.y -= 10
		if player.is_on_ceiling():
			player.machbox.disabled = true
			player.emachbox.disabled = true
			player.mmachbox.disabled = true
			player.mattackbox.disabled = true
			state_machine.transition_to("sjump_hitceiling")
	if player.playercharacter == "SM":
		if Inputs.just_key_attack:
			if Inputs.key_up:
				state_machine.transition_to("upperkick")
			if !Inputs.key_up:
				state_machine.transition_to("tumble")
		if !player.is_on_floor() and Inputs.just_key_down:
			state_machine.transition_to("diving")
		player.velocity.y += player.gravity * delta
		if player.is_on_wall():
			player.machbox.disabled = true
			player.emachbox.disabled = true
			state_machine.transition_to("grapple")
			player.get_input_direction()
		walk()
		if player.is_on_floor():
			state_machine.transition_to("peelland")
	if Inputs.just_key_attack or Inputs.just_key_dash:
		if player.playercharacter == "S":
			player.sjumpreleasesfx.stop()
			player.sjumpentersfx.stop()
			player.velocity.x = lerp(player.velocity.x, player.get_input_direction(), 0)
			player.mmachbox.disabled = true
			player.mattackbox.disabled = true
			state_machine.transition_to("sjump_cancle")
			if !player.face:
				player.velocity.x = lerp(player.velocity.x, player.speedrun2, player.acceleration * delta)
			if player.face:
				player.velocity.x = lerp(player.velocity.x, -player.speedrun2, player.acceleration * delta)
			
func walk():
	if Inputs.key_left:
		player.velocity.x = -player.attack_impulse
	if Inputs.key_right:
		player.velocity.x = player.attack_impulse
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
