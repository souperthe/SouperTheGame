extends Control

var selection = 0
var gotopos = Vector2()
var canselect = true
var settings = false
var maxthings = 3

var directory = Directory.new();
var doFileExists = directory.file_exists(global.savepath)

var disablelvlselect
var selectmode = false
var modeelection = 0
var modedick = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$modeselect.rect_position.y = 540
	$things.visible = true
	var distance = -45
	var distancey = 31.5
	$Pointerglove.position = Vector2($things/play.rect_position.x + distance, $things/play.rect_position.y + distancey)
	objplayer.cutscene()
	if disablelvlselect:
		maxthings = 2
		$things/levelselect.queue_free()
	disablelvlselect = !doFileExists
	music.playtitle()
	pass # Replace with function body.


func _process(_delta):
	options()
	movepointer()
	if canselect:
		inputs()
	if selectmode:
		if not modedick:
			demoselection()
		#things.visible = false
		$things.rect_position.y = lerp($things.rect_position.y,540, 2 * _delta)
		$modeselect.rect_position.y = lerp($modeselect.rect_position.y,0, 5 * _delta)
	pass
	
func inputs():
	if Input.is_action_just_pressed("move_up"):
		$move.play()
		selection += -1
	if Input.is_action_just_pressed("move_down"):
		$move.play()
		selection += 1
	if selection > maxthings:
		selection = 0
	if selection < 0:
		selection = maxthings
func movepointer():
	var pointer = $Pointerglove
	var distance = -45
	var distancey = 31.5
	pointer.visible = canselect
	pointer.position = lerp(pointer.position, gotopos, 0.4)
	if selection == 0:
		gotopos = Vector2($things/play.rect_position.x + distance, $things/play.rect_position.y + distancey)
	if selection == 1:
		gotopos = Vector2($things/settings.rect_position.x + distance + 15, $things/settings.rect_position.y + distancey)
	if selection == 2:
		gotopos = Vector2($things/quit.rect_position.x + distance + 25, $things/quit.rect_position.y + distancey)
	if selection == 3:
		gotopos = Vector2($things/levelselect.rect_position.x + distance - 15, $things/levelselect.rect_position.y + distancey)
	
func options():
	if selection == 0:
		if Input.is_action_just_pressed("confirm"):
			if canselect:
				if !doFileExists:
					startgame()
				if doFileExists:
					$sillysfx.sound()
					selectmode = true
	if selection == 1:
		if Input.is_action_just_pressed("confirm"):
			if canselect:
				$sillysfx.sound()
				$Settings.visible = true
				$Settings.settingson = 1
				$Settings.selection = 1
				settings = true
				canselect = false
				var t = Timer.new()
				t.set_wait_time(0.2)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				$Settings.canselect = 1
		if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("attack"):
			if settings:
				$Settings.visible = false
				$sillysfx.sound()
				$Settings.settingson = 0
				$Settings.canselect = 0
				$Settings.selection = 1
				$Settings.volume = 0
				$Settings.volumenabled = false
				settings = false
				canselect = true
	if selection == 2:
		if Input.is_action_just_pressed("confirm"):
			get_tree().quit()
	if selection == 3:
		if Input.is_action_just_pressed("confirm"):
			startlvlselect()
			
func demoselection():
	selectmode = true
	canselect = false
	if Input.is_action_just_pressed("move_left"):
		$move.play()
		modeelection += -1
	if Input.is_action_just_pressed("move_right"):
		$move.play()
		modeelection += 1
	if Input.is_action_just_pressed("confirm") and $modeselect.rect_position.y < 5:
		$sillysfx.sound()
		modedick = true
		if modeelection == 0:
			startgame()
		if modeelection == 1:
			startgametod()
	if modeelection == 0:
		$modeselect/standard.modulate = Color8(255,0,0)
		$modeselect/tod.modulate = Color8(255,255,255)
		$modeselect/Pointerglove.position.x = lerp($modeselect/Pointerglove.position.x, 336, 0.2)
	if modeelection == 1:
		$modeselect/standard.modulate = Color8(255,255,255)
		$modeselect/tod.modulate = Color8(255,0,0)
		$modeselect/Pointerglove.position.x = lerp($modeselect/Pointerglove.position.x, 629, 0.2)
	if modeelection > 1:
		modeelection = 0
	if modeelection < 0:
		modeelection = 1
		
	
	
	
			
func startgame():
	var dick = false
	if not dick:
		canselect = false
		$sillysfx.sound()
		dick = true
		music.stopmusic()
		var e = Timer.new()
		e.set_wait_time(2.5)
		e.set_one_shot(true)
		self.add_child(e)
		e.start()
		yield(e, "timeout")
		ct._tin()
		var t = Timer.new()
		t.set_wait_time(0.5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		global.level = "entrance"
		ct._tout()
		global.room_goto("res://assets/scenes/entrance/entrance_1.tscn", "door1")
		objplayer.reset()
		if presobjs.player2:
			presobjs.player2.reset()
		objplayer.defaultdir()
		global.hardmode = false
		
		
func startgametod():
	var dick = false
	if not dick:
		canselect = false
		$sillysfx.sound()
		dick = true
		music.stopmusic()
		var e = Timer.new()
		e.set_wait_time(2.5)
		e.set_one_shot(true)
		self.add_child(e)
		e.start()
		yield(e, "timeout")
		ct._tin()
		var t = Timer.new()
		t.set_wait_time(0.5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		global.level = "entrance"
		ct._tout()
		global.room_goto("res://assets/scenes/entrance/entrance_1.tscn", "door1")
		objplayer.reset()
		if presobjs.player2:
			presobjs.player2.reset()
		objplayer.defaultdir()
		global.hardmode = true
		
func startlvlselect():
	var dick = false
	if not dick:
		canselect = false
		$sillysfx.sound()
		dick = true
		var y = Timer.new()
		y.set_wait_time(1.5)
		y.set_one_shot(true)
		self.add_child(y)
		y.start()
		yield(y, "timeout")
		ct._tin()
		var t = Timer.new()
		t.set_wait_time(0.5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		get_tree().change_scene("res://assets/scenes/level_select.tscn")
	
	
	



func _on_Button_pressed():
	OS.alert("message", "title")
	pass # Replace with function body.
