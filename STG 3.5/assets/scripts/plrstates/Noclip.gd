extends PlayerState
export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
var x = 0
var sound_has_played = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#nc _ready():

	
func physics_update(_delta: float) -> void:
	player.disabletitlt = true
	player.machbox.disabled = false
	player.emachbox.disabled = false
	player.candoor = 0
	player.canhurt = false
	if !player.form:
		player.formenter.play()
	animation_player.play("noclip")
	player.form = true
	#player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed, player.acceleration * delta)
	if Inputs.key_right:
		player.position.x += 10
		if Inputs.key_dash:
			player.position.x += 25
			player.trail()
	if Inputs.key_left:
		player.position.x -= 10
		if Inputs.key_dash:
			player.position.x -= 25
			player.trail()
	if Inputs.key_up:
		player.position.y -= 10
		if Inputs.key_dash:
			player.position.y -= 25
			player.trail()
	if Inputs.key_down:
		player.position.y += 10
		if Inputs.key_dash:
			player.position.y += 25
			player.trail()
	if Inputs.just_key_jump:
		state_machine.transition_to("Air", {do_jump = true})
	if Inputs.just_key_attack:
		state_machine.transition_to("Attack")
	if Inputs.just_key_dash:
		state_machine.transition_to("Mach2")
		
		
func exit() -> void:
	player.get_input_direction()
	player.form = false
	player.canhurt = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
