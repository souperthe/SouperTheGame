extends Node

var temp = 0
@onready var leveltheme = $leveltheme
var currentsong = "idk"
var musicvolume := -5.0
var mva := 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !leveltheme.stream == null and leveltheme.playing:
		temp = leveltheme.get_playback_position()
	leveltheme.volume_db = mva * musicvolume
	pass
	
func play(id: String, continueafterlast: bool):
	leveltheme.stream = load(id)
	leveltheme.play()
	currentsong = id
	if continueafterlast:
		leveltheme.seek(float(temp))
		
		
func escapeplay():
	var id := "res://assets/sounds/music/mus_souper_escapenew.ogg"
	leveltheme.stream = load(id)
	leveltheme.play()
	currentsong = id
		
func stop():
	$leveltheme.stop()
	temp = 0
	
