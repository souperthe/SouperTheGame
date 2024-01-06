extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
var hasntlanded = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	hasntlanded = true
	animation_player.play("fp_fall")
	player.velocity.x = 0
	player.mmachbox.disabled = false
	player.mattackbox.disabled = false
	player.fpfallsfx.play()
	
	
func physics_update(delta: float) -> void:
	player.trail()
	player.velocity.y += player.gravity * delta * 5
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if Input.is_action_just_pressed(player.input_attack):
		player.get_input_direction()
		state_machine.transition_to("tumble")
	if player.is_on_floor():
		if global.camera:
			global.camera.shake(10)
	if player.is_on_floor() and hasntlanded:
		player.poundpart()
		player.fpfallsfx.stop()
		player.hitwall.play()
		player.step.play()
		hasntlanded = false
		player.velocity.y = -player.jump_impulse
		state_machine.transition_to("Air")
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
