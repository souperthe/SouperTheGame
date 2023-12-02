extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.hitpartical()
	animation_player.play("sjump_hitceiling")
	player.hitwall.play()
	player.hitceiling.play()
	player.velocity.y = 0
	player.velocity.x = 0
	player.disabletitlt = false
	
	
func physics_update(_delta: float) -> void:
	if player.animatonframes == 5:
		state_machine.transition_to("Air")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
