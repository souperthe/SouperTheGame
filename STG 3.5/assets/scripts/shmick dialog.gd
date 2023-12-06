extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = false
var text


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var thingy = $Control/thing.rect_position.y
	$Control/thing/RichTextLabel.bbcode_text = str("[shake rate=10.0 level=5 connected=1]", text, "[/shake]")
	if active:
		$Control/thing.rect_position.y = lerp($Control/thing.rect_position.y, 44, 0.1)
	if !active:
		$Control/thing.rect_position.y = lerp($Control/thing.rect_position.y, -164, 0.1)
