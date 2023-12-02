extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var canbounce = false
var speed = 1050

# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	canbounce = false
	animation_player.play("slip")
	player.velocity.y = -player.jump_impulse
	player.mach3.stop()
	player.turntimer.stop()
	player.fpfallsfx.stop()
	player.candoor = 0
	speed = 1050
	if player.face:
		player.velocity.x = -speed
	if !player.face:
		player.velocity.x = speed
	yield(get_tree().create_timer(0.2), "timeout")
	canbounce = true
	
	
func physics_update(delta: float) -> void:
	var collision = player.move_and_collide(player.velocity * delta)
	if collision:
		if canbounce:
			animation_player.play("hardtumble")
			animation_player.frame = 0
			animation_player.flip_h = !animation_player.flip_h
			player.face = !player.face 
			player.sfxbump.play()
			player.velocity = player.velocity.bounce(collision.normal)
			player.velocity.x = -speed / 0.2
	if player.form:
			player.formexit.play()
			player.form = false
	player.machbox.disabled = false
	player.emachbox.disabled = false
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if player.is_on_floor():
		state_machine.transition_to("peelland")
		




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
