extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.bangeffect()
	animation_player.play("bumpwall")
	player.sfxbump.play()
	player.hitwall.play()
	player.mach3.stop()
	if global.camera:
		global.camera.shake2(2, 0.2)

func physics_update(_delta: float) -> void:
	player.velocity.y = 0
	player.velocity.x = 0
	#global.camera.shake(2)
	if player.animatonframes > 4:
		state_machine.transition_to("Idle")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
