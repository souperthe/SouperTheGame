extends PlayerState


export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	animation_player.play("sjump_release")
	player.sjumpreleasesfx.play()
	player.machbox.disabled = true
	player.emachbox.disabled = true
	player.mmachbox.disabled = false
	player.mattackbox.disabled = false
	player.velocity.y = -980
	
func exit() -> void:
	player.sjumpreleasesfx.stop()
	
	
func physics_update(delta: float) -> void:
	player.trail()
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	player.velocity.x = lerp(player.velocity.x, 0, player.air_friction * delta)
	player.velocity.y -= 10
	if player.is_on_ceiling():
		player.machbox.disabled = true
		player.emachbox.disabled = true
		player.mmachbox.disabled = true
		player.mattackbox.disabled = true
		state_machine.transition_to("sjump_hitceiling")
	if Input.is_action_just_pressed(player.input_attack) or Input.is_action_just_pressed(player.input_run):
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
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
