extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)

var speed = 1050
var lastxvel
var mach3speed = 1580
var canjump = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	#player.get_input_direction()
	if !player.currentstate == ("diving"):
		lastxvel = player.velocity.x
	animation_player.play("mach2")
	player.mach3.play()
	player.candoor = 1
	player.velocity.y = 0
	if lastxvel < 1050:
		speed = 1050
	if !lastxvel < 1050:
		speed = lastxvel
	player.speedpart.emitting = false
	player.pmachbox.disabled = false
	player.machbox.disabled = false
	player.emachbox.disabled = false
	if !player.face:
		player.velocity.x = speed
	if player.face:
		player.velocity.x = -speed
	#if _msg.has("do_turn"):
		#player.get_input_direction()
	pass
	
func physics_update(delta: float) -> void:
	if player.gun and Inputs.just_key_shoot:
		state_machine.transition_to("gunfire")
	player.disabletitlt = false
	if Inputs.just_key_attack:
		state_machine.transition_to("tumble")
	if player.is_on_floor():
		player.speedpart.emitting = true
	if !player.is_on_floor():
		player.speedpart.emitting = false
	if player.playercharacter == "S":
		speed += 50 * delta
	if player.playercharacter == "SM":
		if player.is_on_floor():
			speed += 50 * delta
	player.trail()
	player.velocity.y += player.gravity * delta
	var was_on_floor = player.is_on_floor()
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	var just_left_ledge = was_on_floor and not player.is_on_floor() and player.velocity.y >= 0
	if just_left_ledge:
		player.cayatotime.start()
	if !player.face and player.is_on_floor():
		if player.velocity.x > mach3speed:
			state_machine.transition_to("Mach3")
		if Inputs.just_key_left:
			state_machine.transition_to("MachTurn", {one = true})
		#player.velocity.x = speed
	if player.face and player.is_on_floor():
		if player.velocity.x < -mach3speed:
			state_machine.transition_to("Mach3")
		if Inputs.just_key_right:
			state_machine.transition_to("MachTurn", {one = true})
		#player.velocity.x = -speed
	match(player.face):
		false:
			player.velocity.x = speed
		true:
			player.velocity.x = -speed
	if canjump and Inputs.just_key_jump:
		state_machine.transition_to("mach_jump", {do_jump = true})
	if player.walled or player.is_on_wall():
		state_machine.transition_to("bumpwall")
		#player.hitwall.play()
		player.mach3.stop()
	#if player.is_on_wall():
		#player.walled = true
	if player.is_on_floor() and Inputs.just_key_up:
		state_machine.transition_to("sjump_prep")
		player.mach3.stop()
	if player.is_on_floor() and Inputs.key_down:
		state_machine.transition_to("crouchsliding")
	if !player.canuncrouch:
		state_machine.transition_to("crouchsliding")
	if !player.is_on_floor() and Inputs.just_key_down:
		state_machine.transition_to("diving")
		player.mach3.stop()
		
		
func exit() -> void:
	player.speedpart.emitting = false
	player.pmachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
	player.mach3.stop()
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
