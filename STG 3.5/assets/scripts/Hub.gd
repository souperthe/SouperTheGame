extends Node2D


onready var circle_transition = $CanvasLayer/Control/circletrans


func _ready() -> void:
	ct._tout()
	music.playcity()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
