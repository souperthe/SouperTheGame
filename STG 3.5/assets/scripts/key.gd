extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.othersroom.has(global.targetRoom2 + name)):
		queue_free()
	pass # Replace with function body.



func _process(delta):
	if not objplayer.haskey:
		$AnimatedSprite.modulate.a8 = 255
	if objplayer.haskey:
		$AnimatedSprite.modulate.a8 = 125
	pass


func _on_key_area_entered(area):
	if not objplayer.haskey:
		global.othersroom.append(global.targetRoom2 + name)
		global.resetcombo()
		objplayer.haskey = true
		queue_free()
		global.playsmall()
