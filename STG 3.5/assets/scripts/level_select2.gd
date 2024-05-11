extends Control

var levels = {
	"house": "res://assets/scenes/entrance/entrance_1.tscn",
	"city": "res://assets/scenes/city/city_1.tscn",
	"snow": "res://assets/scenes/snow/snow_1.tscn",
	"mansion": "res://assets/scenes/mansion/mansion_1.tscn",
	"boss": "res://assets/scenes/boss_test.tscn",
	"tutorial": "res://assets/scenes/tutorial/tutorial_1.tscn",
	"test level": "res://assets/scenes/test.tscn"
}

var amount = 0
var selection = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	amount = levels.size()
	objplayer.gooffscreen()
	ct._tout()
	pass # Replace with function body.

var keys = Array(levels.keys());
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selection < 1:
		selection = amount
	if selection > amount:
		selection = 1
	if Inputs.just_key_right:
		selection += 1
	if Inputs.just_key_left:
		selection -= 1
	if selection < amount and selection > 0:
		$text.bbcode_text = str("[center]", keys[selection])
#	pass
