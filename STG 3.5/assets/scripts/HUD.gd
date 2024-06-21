extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var alpha = modulate.a8


# Called when the node enters the scene tree for the first time.
func _ready():
	$fallen.visible = false
	pass # Replace with function body.


func _process(delta):
	if global.cutscene:
		modulate.a8 = global.Approach(modulate.a8, 0, 15)
	if !global.cutscene:
		modulate.a8 = global.Approach(modulate.a8, 255, 15)
		#$Tween.interpolate_property(self, "modulate:a", modulate.a8, 0.0, 0.3, 0, 1)
