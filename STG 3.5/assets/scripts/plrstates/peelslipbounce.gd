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
	animation_player.play("hardtumble")
	var jumpheight = 670 * 2
	player.velocity.y = -jumpheight
	player.mach3.stop()
	player.turntimer.stop()
	player.fpfallsfx.stop()
	player.candoor = 0
	speed = 1050
	#if player.face:
		#player.velocity.x = -speed
	#if !player.face:
		#player.velocity.x = speed
	
	
func physics_update(delta: float) -> void:
	if player.form:
			player.formexit.play()
			player.form = false
	player.machbox.disabled = false
	player.emachbox.disabled = false
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	player.trail()
	if player.is_on_wall():
		player.velocity.x = -600
		animation_player.play("hardtumble")
		animation_player.frame = randi() % 6
		animation_player.flip_h = !animation_player.flip_h
		player.face = !player.face 
		player.sfxgrapple.play()
		player.goofysound()
		speed = speed / 1.5
		#peed = speed + speed
		player.velocity.y = -0
		player.hurteffect()
		#player.velocity.x = -speed
		if !player.face:
			player.velocity.x = -speed
		if player.face:
			player.velocity.x = speed
		#if player.velocity.x > 0:
			#player.velocity.x = speed
		#if player.velocity.x < 0:
			#player.velocity.x = -speed
	if player.animatonframes > 7:
		player.trail()
	if player.is_on_floor():
		state_machine.transition_to("peelland")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
