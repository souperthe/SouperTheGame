extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
var hasntlanded = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var move = 0


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	hasntlanded = true
	animation_player.play("fp_fall")
	#player.velocity.x = 0
	player.mmachbox.disabled = false
	player.mattackbox.disabled = false
	player.fpfallsfx.play()
	
	
func physics_update(delta: float) -> void:
	move = int(Inputs.key_right) - int(Inputs.key_left)
	player.velocity.x = lerp(player.velocity.x, move * player.attack_impulse * 2, 0.1)
	player.trail()
	player.velocity.y += player.gravity * delta * 3
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	#walk()
	#if Inputs.just_key_attack:
		#player.get_input_direction()
		#state_machine.transition_to("tumble")
	#if player.is_on_floor():
		#if global.camera:
			#global.camera.shake(10)
	if player.is_on_floor() and hasntlanded:
		player.poundpart()
		player.fpfallsfx.stop()
		player.hitwall.play()
		player.step.play()
		hasntlanded = false
		player.velocity.y = -player.jump_impulse
		state_machine.transition_to("Air")
		if global.camera:
			global.camera.shake2(5, 0.2)
		player.machbox.disabled = true
		player.emachbox.disabled = true
		
		
func exit() -> void:
	player.pmachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
	player.mmachbox.disabled = true
	player.mattackbox.disabled = true
	player.fpfallsfx.stop()
	player.mach3.stop()
	
#func walk():
	#move = int(Inputs.key_left) - int(Inputs.key_right)
	#if Inputs.key_left:
		#player.velocity.x = -player.speed * 2
	#i#f Inputs.key_right:
		#player.velocity.x = player.speed * 2
	#if !Inputs.key_left and !Inputs.key_right:
		#player.velocity.x = 0
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
