extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.velocity.y = -250
	pass # Replace with function body.
	
func physics_update(_delta: float) -> void:
	player.velocity.x = 0
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	player.disabletitlt = true
	if not Inputs.key_up and not Inputs.key_down:
		animation_player.play("climbidle")
	if Inputs.key_up:
		animation_player.play("climbup")
		player.velocity.y = -250 * 1.5
	if Inputs.key_down:
		animation_player.play("climbdown")
		player.velocity.y = 450 * 1.5
	if Inputs.just_key_jump:
		player.velocity.y = -player.jump_impulse
		state_machine.transition_to("Air", {do_jump = true})
	if not player.ladder:
		state_machine.transition_to("Air")
	if !Inputs.key_up and !Inputs.key_down and !Inputs.just_key_jump:
		player.velocity.y = 0
	if player.is_on_floor():
			if player.velocity.y < 450:
				state_machine.transition_to("Idle")
		
		
		
func exit() -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	player.disabletitlt = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
