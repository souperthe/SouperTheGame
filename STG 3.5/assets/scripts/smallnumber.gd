extends Node2D

var number = "1"
var green = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.


func _process(_delta):
	position.y -= 1
	modulate.a8 -= 2
	$RichTextLabel.bbcode_text = number
	if green:
		$RichTextLabel.modulate.g8 = 255
		$RichTextLabel.modulate.r8 = 0
		$RichTextLabel.modulate.b8 = 0
	if !green:
		$RichTextLabel.modulate.g8 = 0
		$RichTextLabel.modulate.r8 = 255
		$RichTextLabel.modulate.b8 = 0
	
	pass


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.


func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
	pass # Replace with function body.
