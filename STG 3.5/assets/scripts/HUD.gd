extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var alpha = modulate.a8


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if global.cutscene:
		modulate.a8 = lerp(modulate.a8, 0, 7 * delta)
	if !global.cutscene:
		modulate.a8 = lerp(modulate.a8, 255, 7 * delta)
