extends PlayerState


export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.trail()
	player.attackbox.disabled = false
	player.eattackbox.disabled = false
	var my_random_number = rng.randi_range(0.0, 1.0)
	#print(my_random_number)
	if my_random_number == 1:
		animation_player.play("kick")
	if my_random_number == 0:
		animation_player.play("punch")
	player.attacksfx.play()
	
	
func physics_update(delta: float) -> void:
	if player.is_on_wall():
		state_machine.transition_to("bump")
	if !player.face:
		player.velocity.x = player.attack_impulse
	if player.face:
		player.velocity.x = -player.attack_impulse
	if Input.is_action_just_pressed(player.input_attack):
		state_machine.transition_to("tumble")
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	#if !player.face:
		#player.velocity.x = lerp(player.velocity.x, player.speed, player.acceleration * delta)
	#if player.face:
		#player.velocity.x = lerp(player.velocity.x, -player.speed, playerx.acceleration * delta)
	if player.animatonframes == 5:
		player.attackbox.disabled = true
		player.eattackbox.disabled = true
		state_machine.transition_to("Idle")
		
func exit() -> void:
	player.attackbox.disabled = true
	player.eattackbox.disabled = true
	player.speedpart.emitting = false
	player.pmachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
