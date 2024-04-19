extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var canbounce = false
var speed = 1050
var bounces = false
var realvelocity


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	canbounce = false
	animation_player.frame = 0
	animation_player.play("slip")
	player.velocity.y = -player.jump_impulse
	player.mach3.stop()
	player.turntimer.stop()
	player.fpfallsfx.stop()
	player.candoor = 0
	speed = abs(player.velocity.x)
	bounces = false
	#if player.face:
		#player.velocity.x = -speed
	#if !player.face:
		#player.velocity.x = speed
	
	
func physics_update(delta: float) -> void:
	realvelocity = player.velocity / 60
	if player.form:
			player.formexit.play()
			player.form = false
	player.machbox.disabled = false
	player.emachbox.disabled = false
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	if player.is_on_wall():
		player.bangeffect()
	#	player.punchsound()
		#speed = abs(player.velocity.x)
		#speed = speed / 2
		player.velocity.x = -600
		animation_player.play("hardtumble")
		animation_player.frame = randi() % 6
		animation_player.flip_h = !animation_player.flip_h
		player.face = !player.face 
		player.sfxgrapple.play()
		player.goofysound()
		player.punchsound()
		global.camera.shake2(5, 0.1)
		#speed = speed / 1.5
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
		if !abs(realvelocity.x) < 2:
			animation_player.play("hardtumble")
			player.sfxgrapple.play()
			player.bangeffect()
			player.goofysound()
			player.punchsound()
			global.camera.shake2(5, 0.1)
			animation_player.flip_h = !animation_player.flip_h
			player.face = !player.face 
			#speed = speed / 1.5
			#peed = speed + speed
			player.velocity.y = -player.jump_impulse
			#player.position.y -= 10
			player.velocity.x = player.velocity.x / 2
			#bounces = true
			player.hurteffect()
		if abs(realvelocity.x) < 10:
			state_machine.transition_to("peelland")
			global.camera.shake2(5, 0.1)
			player.bangeffect()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
