extends Node

var temp = 0
@onready var leveltheme = $leveltheme
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !leveltheme.stream == null:
		temp = leveltheme.get_playback_position()
	pass
	
func play(id: String, continueafterlast: bool):
	leveltheme.stream = load(id)
	leveltheme.play()
	if continueafterlast:
		leveltheme.seek(float(temp))
		
func stop():
	$leveltheme.stop()
	
