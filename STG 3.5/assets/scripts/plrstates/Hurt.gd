extends PlayerState


export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	if player.form:
			player.formexit.play()
			player.form = false
	player.hitpartical()
	player.velocity.y = -player.jump_impulse * 1.2
	player.mach3.stop()
	player.hurttimer.start()
	player.turntimer.stop()
	player.fpfallsfx.stop()
	player.pmachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
	player.disabletitlt = false
	player.candoor = 0
	if !player.face:
		player.velocity.x = -player.jump_impulse / 1.2
	if player.face:
		player.velocity.x = player.jump_impulse / 1.2
	var rng = global.randi_range(1,5)
	if rng == 4:
		player.voicenegative()
	pass
	
func physics_update(delta: float) -> void:
	player.pmachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
	animation_player.play("hurt")
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	player.velocity.x = lerp(player.velocity.x, 0, player.friction / 50 * delta)
	if player.is_on_floor():
		state_machine.transition_to("Idle")
		player.hurttimer.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func exit() -> void:
	player.hurttimer.stop()


func _on_hurtimer_timeout():
	if player.currentstate == ("Hurt"):
		goback()
		
		
func goback():
	player.disabletitlt = false
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	if !player.is_on_floor():
		state_machine.transition_to("Air")
		
		
func createdead1():
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = player.position.x
	ghost.position.y = player.position.y
	ghost.velocity.y = -900
	ghost.velocity.x = 0
	ghost.spinamount = 2
	ghost.sprite.texture = load("res://assets/sprites/player_souper/gun.png")
	ghost.sprite.scale.x = 0.56
	ghost.sprite.scale.y = 0.56


func _on_iframes_timeout():
	#player.canhurt = true
	pass # Replace with function body.
