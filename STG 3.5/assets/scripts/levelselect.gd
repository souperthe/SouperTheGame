extends Node


# Declare member variables here. Examples:
var selection = 2
var canselect = true
var canconfirm = true
var targeticon = "res://icon.png"
var username
var hello = "Hello"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	global.hardmode = $hardmode.pressed
	if Inputs.just_key_dash:
		$hardmode.pressed = !$hardmode.pressed
		$move.play()
	if Inputs.just_key_left:
		if canselect:
			selection -= 1
			$move.play()
	if Inputs.just_key_right:
		if canselect:
			selection += 1
			$move.play()
	if selection == 0:
		$levels.play("snow")
	if selection == 1:
		$levels.play("city")
	if selection == 2:
		$levels.play("entrance")
	if selection == 3:
		$levels.play("retro")
	if selection == 4:
		$levels.play("unknown")
	if selection == 5:
		$levels.play("intro")
	if selection == 6:
		$levels.play("sissy")
	if selection == 7:
		$levels.play("boss")
	if selection == 8:
		$levels.play("brah")
	if selection == 9:
		$levels.play("unknown")
	if selection > 9:
		selection = 0
	if selection < 0:
		selection = 9
	if Input.is_action_just_pressed("confirm") and canconfirm:
		$selected.play()
		music.stopmusic()
		canselect = false
		canconfirm = false
		yield(get_tree().create_timer(1.0), "timeout")
		ct._tin()
		yield(get_tree().create_timer(1.0), "timeout")
		if selection == 0:
			global.level = "snow"
			ct._tout()
			global.room_goto("res://assets/scenes/snow/snow_1.tscn", "door1")
			objplayer.reset()
			if presobjs.player2:
				presobjs.player2.reset()
			objplayer.defaultdir()
		if selection == 1:
			global.level = "city"
			ct._tout()
			global.room_goto("res://assets/scenes/city/city_1.tscn", "door1")
			objplayer.reset()
			if presobjs.player2:
				presobjs.player2.reset()
			objplayer.defaultdir()
		if selection == 2:
			global.level = "entrance"
			ct._tout()
			global.room_goto("res://assets/scenes/entrance/entrance_1.tscn", "door1")
			objplayer.reset()
			if presobjs.player2:
				presobjs.player2.reset()
			objplayer.defaultdir()
		if selection == 3:
			global.level = "none"
			ct._tout()
			global.room_goto("res://assets/ignore/porting/1-1.tscn", "door1")
			objplayer.reset()
			if presobjs.player2:
				presobjs.player2.reset()
			objplayer.defaultdir()
		if selection == 4:
			global.level = "none"
			ct._tout()
			global.room_goto("res://assets/scenes/misc/oldsouper.tscn", "door1")
			objplayer.reset()
			if presobjs.player2:
				presobjs.player2.reset()
			objplayer.defaultdir()
		if selection == 5:
			global.level = "none"
			ct._tout()
			global.room_goto("res://assets/scenes/testD.tscn", "door1")
			objplayer.reset()
			if presobjs.player2:
				presobjs.player2.reset()
			objplayer.defaultdir()
		if selection == 6:
			global.level = "sispus"
			ct._tout()
			global.room_goto("res://assets/scenes/misc/sisyphus.tscn", "door1")
			objplayer.reset()
			if presobjs.player2:
				presobjs.player2.reset()
			objplayer.defaultdir()
		if selection == 7:
			global.level = "boss"
			ct._tout()
			global.room_goto("res://assets/scenes/boss_test.tscn", "door1")
			objplayer.reset()
			if presobjs.player2:
				presobjs.player2.reset()
			objplayer.defaultdir()
		if selection == 8:
			global.level = "test"
			ct._tout()
			global.room_goto("res://assets/scenes/test.tscn", "door1")
			objplayer.reset()
			if presobjs.player2:
				presobjs.player2.reset()
			objplayer.defaultdir()
		if selection == 9:
			global.level = "test"
			ct._tout()
			global.room_goto("res://assets/scenes/tutorial/tutorial_1.tscn", "door1")
			objplayer.reset()
			if presobjs.player2:
				presobjs.player2.reset()
			objplayer.defaultdir()
		
