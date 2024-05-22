extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var jumpheight = 670 * 2
var thing = false
var speed = 1050


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	thing = false
	player.hitpartical()
	music.stopmusic()
	global.cutscene = true
	player.hurtsfx.play()
	animation_player.play("hardtumble")
	player.velocity.y = -jumpheight
	player.darkeffect.modulate.a8 = 0
	player.darkeffect.visible = true
	player.candoor = 0
	player.canhurt = false
	speed = 1050
	global.info(str("[wave]Press ", OS.get_scancode_string(Inputs.input_attack), " to restart"), 60)
	#if player.face:
		#player.velocity.x = -speed
	#if !player.face:
		#player.velocity.x = speed
	pass # Replace with function body.
	
func physics_update(delta: float) -> void:
	player.makethingnotvisible()
	player.pmachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
	player.disabletitlt = false
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	player.iframestimer.start()
	if Inputs.just_key_attack:
			player.restartlevel()
			player.iframestimer.stop()
			global.info("", 1)
	if player.is_on_wall() and not thing:
		player.velocity.x = -600
		animation_player.play("hardtumble")
		animation_player.frame = 0
		animation_player.flip_h = !animation_player.flip_h
		player.face = !player.face 
		player.sfxgrapple.play()
		#player.goofysound()
		speed = speed / 1.5
		player.velocity.y = -0
		#player.hurteffect()
		#player.velocity.x = -speed
		if !player.face:
			player.velocity.x = -speed
		if player.face:
			player.velocity.x = speed
	if thing:
		#global.camerazoom = lerp(global.camerazoom, 0.5, 2 * delta)
		player.velocity.x = lerp(player.velocity.x, 0, player.air_friction * delta)
		#player.darkeffect.modulate.a8 = lerp(player.darkeffect.modulate.a8, 280, 2 * delta)
	
	if player.is_on_floor() and not thing:
		player.cutvoices()
		thing = true
		player.velocity.y = 0
		player.hitpartical()
		animation_player.play("slipland")
		player.sfxbump.play()
		player.hitwall.play()
		
func exit() -> void:
	player.darkeffect.modulate.a8 = 0
	player.darkeffect.visible = false
	global.camerazoom = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
