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

	
func physics_update(delta: float) -> void:
	player.disabletitlt = true
	player.machbox.disabled = false
	player.emachbox.disabled = false
	player.candoor = 0
	player.canhurt = false
	if !player.form:
		player.formenter.play()
	animation_player.play("noclip")
	player.form = true
	player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed, player.acceleration * delta)
	if Input.is_action_pressed(player.input_right):
		player.position.x += 10
		if Input.is_action_pressed(player.input_run):
			player.position.x += 25
			player.trail()
	if Input.is_action_pressed(player.input_left):
		player.position.x -= 10
		if Input.is_action_pressed(player.input_run):
			player.position.x -= 25
			player.trail()
	if Input.is_action_pressed(player.input_up):
		player.position.y -= 10
		if Input.is_action_pressed(player.input_run):
			player.position.y -= 25
			player.trail()
	if Input.is_action_pressed(player.input_down):
		player.position.y += 10
		if Input.is_action_pressed("run"):
			player.position.y += 25
			player.trail()
	if Input.is_action_just_pressed(player.input_jump):
		state_machine.transition_to("Air", {do_jump = true})
	if Input.is_action_just_pressed(player.input_attack):
		state_machine.transition_to("Attack")
		
		
func exit() -> void:
	player.form = false
	player.canhurt = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
