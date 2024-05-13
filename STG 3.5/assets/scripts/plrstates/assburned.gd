extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.animation2.play("startmach3")
	#if !player.currentstate == ("assburned"):
	player.voicenegative()
	player.attackbox.disabled = false
	player.eattackbox.disabled = false
	var jumpheight = 670 * 2
	animation_player.play("assburn")
	player.velocity.y = -jumpheight
	player.sfxburn.play()
	player.asspart.emitting = true


func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if player.is_on_floor():
		state_machine.transition_to("peelland")
	if not is_zero_approx(player.get_input_direction()):
		#player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed, player.acceleration * delta)
		walk()
		
		
func walk():
	if Inputs.key_left:
		player.velocity.x = -player.attack_impulse
	if Inputs.key_right:
		player.velocity.x = player.attack_impulse
	
	
func exit() -> void:
	player.asspart.emitting = false
	player.attackbox.disabled = true
	player.eattackbox.disabled = true
	player.speedpart.emitting = false
	player.pmachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
