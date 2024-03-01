extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	animation_player.stop()
	#player.turntimer.stop()
	#player.hurttimer.stop()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
