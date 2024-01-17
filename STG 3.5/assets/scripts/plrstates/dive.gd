extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lastxvel


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("dive")
	#if !player.currentstate == ("dive"):
		#lastxvel = player.velocity.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
