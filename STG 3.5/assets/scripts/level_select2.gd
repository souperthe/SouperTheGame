extends Control

var levels = {
	"house": "res://assets/scenes/entrance/entrance_1.tscn",
	"city": "res://assets/scenes/city/city_1.tscn",
	"snow": "res://assets/scenes/snow/snow_1.tscn",
	"haunted house": "res://assets/scenes/mansion/mansion_1.tscn",
	"boss": "res://assets/scenes/boss_test.tscn",
	"tutorial old": "res://assets/scenes/tutorial/tutorial_1.tscn",
	"test level": "res://assets/scenes/test.tscn",
	"online testing (being reworked)": "res://assets/scenes/misc/partytest.tscn",
	"old snow": "res://assets/scenes/snowold/snowold_1.tscn",
	"retro 1": "res://assets/scenes/misc/oldsouper.tscn",
	"one must imagine souper happy": "res://assets/scenes/misc/sisyphus.tscn",
	"1-1 recreation": "res://assets/ignore/porting/1-1.tscn",
	"old title screen (WILL BREAK YOUR GAME)": "res://assets/scenes/Menu.tscn"
}

var amount = 0
var selection = 1
var canselect = true
var playing = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	objplayer.cutscene()
	amount = levels.size() - 1
	objplayer.gooffscreen()
	ct._tout()
	pass # Replace with function body.

var keys = Array(levels.keys());
var values = Array(levels.values());
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Inputs.just_key_jump:
		playing = !playing
	if Inputs.just_key_attack:
		global.hardmode = !global.hardmode
	match(global.hardmode):
		true:
			$Tod0001.modulate = Color8(255,255,255,255)
		false:
			$Tod0001.modulate = Color8(0,0,0,255)
	match(playing):
		false:
			$souper.texture = load("res://assets/sprites/player_souper/souperanim_0001.png")
			objplayer.playercharacter = "S"
			objplayer.animator.frames = load("res://assets/important/souperframes.tres")
		true:
			$souper.texture = load("res://assets/sprites/player_sockman/sockmananim_0001.png")
			objplayer.playercharacter = "SM"
			objplayer.animator.frames = load("res://assets/important/sockmanframes.tres")
	if selection < 0:
		selection = levels.size() - 1
	if selection > levels.size() - 1:
		selection = 0
	if Inputs.just_key_right:
		selection += 1
	if Inputs.just_key_left:
		selection -= 1
	$text.bbcode_text = str("[center]", str(keys[selection - 1]))
	$text2.text = str("press ", OS.get_scancode_string(Inputs.input_jump), " to switch character")
	$text3.text = str("press ", OS.get_scancode_string(Inputs.input_attack), " to toggle tod mode")
	if Inputs.just_key_enter:
		if canselect:
			music.stopmusic()
			gotoroom()
			canselect = false
			$sillysfx.sound()
#	pass

func gotoroom():
	yield(get_tree().create_timer(1.0), "timeout")
	ct._fin()
	yield(get_tree().create_timer(1.0), "timeout")
	global.room_goto(str(values[selection - 1]), "door1")
	objplayer.reset()
	ct._fout()
