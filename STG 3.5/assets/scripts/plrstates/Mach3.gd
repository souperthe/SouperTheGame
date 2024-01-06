extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)

var speed = 1050
var started = false
var canjump = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.mach4.play()
	player.animation2.play("startmach3")
	animation_player.play("mach3")
	player.candoor = 1
	player.velocity.y = 0
	speed = 2050
	player.pmachbox.disabled = false
	player.machbox.disabled = false
	player.emachbox.disabled = false
	if !player.face:
		player.velocity.x = speed
	if player.face:
		player.velocity.x = -speed
	pass
	
func physics_update(delta: float) -> void:
	if player.gun and Input.is_action_just_pressed(player.input_shoot):
		state_machine.transition_to("gunfire")
	player.disabletitlt = false
	if Input.is_action_just_pressed(player.input_attack):
		state_machine.transition_to("tumble")
	if player.is_on_floor() and player.currentstate == "Mach3":
		player.speed3part.emitting = true
		player.speedpart.emitting = true
	else:
		player.speed3part.emitting = false
		player.speedpart.emitting = false
	if !player.face:
		player.velocity.x = speed
	if player.face:
		player.velocity.x = -speed
	
	speed += 6
	player.trail()
	player.velocity.y += player.gravity * delta
	var was_on_floor = player.is_on_floor()
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	var just_left_ledge = was_on_floor and not player.is_on_floor() and player.velocity.y >= 0
	if just_left_ledge:
		player.cayatotime.start()
	if !player.face and player.is_on_floor():
		if Input.is_action_pressed(player.input_left):
			state_machine.transition_to("MachTurn", {two = true})
	if player.face and player.is_on_floor():
		if Input.is_action_pressed(player.input_right):
			state_machine.transition_to("MachTurn", {two = true})
	if canjump and Input.is_action_just_pressed(player.input_jump):
		state_machine.transition_to("mach_jump", {do_jump = true})
	if player.is_on_wall():
		state_machine.transition_to("bumpwall")
		player.hitwall.play()
		player.mach4.stop()
		player.hurteffect()
	if player.is_on_floor() and Input.is_action_just_pressed(player.input_up):
		state_machine.transition_to("sjump_prep")
		player.mach4.stop()
	if !player.is_on_floor() and Input.is_action_just_pressed(player.input_down):
		state_machine.transition_to("fallpound_start")
		player.mach4.stop()
		
		
func exit() -> void:
	started = false
	player.speedpart.emitting = false
	player.speed3part.emitting = false
	player.pmachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
	player.mach4.stop()
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
