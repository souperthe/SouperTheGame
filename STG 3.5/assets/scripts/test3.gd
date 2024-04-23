extends Sprite

export (NodePath) var otherend
onready var otherend2:Sprite = get_node(otherend)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if $Area2D.overlaps_body(objplayer):
		objplayer.position = otherend2.position
		$AudioStreamPlayer2D.play()
#	pass
