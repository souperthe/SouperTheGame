extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.hitpartical()
	animation_player.play("slipland")
	player.sfxbump.play()
	player.hitwall.play()
	player.hitwall.play()
	player.velocity.y = 0
	player.emachbox.disabled = true
	player.machbox.disabled = true
	
	
func physics_update(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0, player.air_friction * delta)
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)	
	if player.animatonframes > 4:
		state_machine.transition_to("Idle")
		
		
		
func playfunny():
	yield(get_tree().create_timer(0.2), "timeout")
	player.sfxfunny.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
