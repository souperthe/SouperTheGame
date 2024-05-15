extends Control

var paused = false
var selection = 1
var canselect = true
var canpause = true
var settings = false
export (bool) var enabled
onready var show = $CenterContainer/RightBar/Show
func _ready():
	show.position.y = 126
	show.position.x = -138
	get_tree().paused = false
func _process(_delta):
	#if roomhandle.currentscene.name == "menu" and roomhandle.currentscene.name == "rankroom":
	#	pass
	if !roomhandle.currentscene.name == "menu" and !roomhandle.currentscene.name == "rankroom" and !roomhandle.currentscene.name == "gameover":
		if enabled:
			menu()
	#print(selection)
	


func _on_Resume_pressed():
	get_tree().paused = false
	self.visible = false
	
func song():
	if paused:
		$AnimationPlayer.play("start")
		$enter.play()
		$exit.stop()
		$song.play()
		selection = 1
	if !paused:
		$AnimationPlayer.play("exit")
		$exit.play()
		$enter.stop()
		$song.stop()
		
func menu():
	$CenterContainer/Score/scoretext2.text = (str(global.score))
	if !global.treasure:
		$CenterContainer/treasure/treasure.text = "No Treasure"
	if global.treasure:
		$CenterContainer/treasure/treasure.text = "Treasure Found"
	if global.level == "hub":
			$CenterContainer/RightBar/restart.modulate.a8 = 125
	if !global.level == "hub":
			$CenterContainer/RightBar/restart.modulate.a8 = 255
	if Inputs.just_key_pause and canpause:
		get_tree().paused = !get_tree().paused
		self.visible = !self.visible
		paused = !paused
		song()
	if Inputs.just_key_pause or Inputs.just_key_attack:
		if settings and $Settings.selectedmenu == $Settings.menus.main:
			$Settings.visible = false
			#$Settings.playconfirm()
			$Settings.settingson = 0
			$Settings.canselect = 0
			$Settings.selection = 1
			#$Settings.volume = 0
			#$Settings.volumenabled = false
			settings = false
			canpause = true
			canselect = true
		
	if Inputs.just_key_up:
		if paused and canselect:
			$move.play()
			selection -= 1
	if Inputs.just_key_down:
		if paused and canselect:
			selection += 1
			$move.play()
	if selection > 4:
		selection = 1
	if selection < 1:
		selection = 4
	#selection shower positions
	if paused:
		#print(selection)
		if selection == 1:
			$CenterContainer/RightBar/Resume.use_parent_material = false
			$CenterContainer/RightBar/Settings.use_parent_material = true
			$CenterContainer/RightBar/Titlescreen.use_parent_material = true
			$CenterContainer/RightBar/restart.use_parent_material = true
			show.position.y = 126
			show.position.x = -138
			if Inputs.just_key_enter:
				if canselect:
					get_tree().paused = !get_tree().paused
					self.visible = !self.visible
					paused = !paused
					song()
		if selection == 2:
			$CenterContainer/RightBar/Resume.use_parent_material = true
			$CenterContainer/RightBar/Settings.use_parent_material = false
			$CenterContainer/RightBar/Titlescreen.use_parent_material = true
			$CenterContainer/RightBar/restart.use_parent_material = true
			show.position.y = 602
			show.position.x = 186
			if Inputs.just_key_enter:
				if canselect:
					$Settings.visible = true
					$Settings.reset()
					$Settings.settingson = 1
					$Settings.canselect = 1
					$Settings.selection = 1
					settings = true
					canpause = false
					canselect = false
		if selection == 3:
			$CenterContainer/RightBar/Resume.use_parent_material = true
			$CenterContainer/RightBar/Settings.use_parent_material = true
			$CenterContainer/RightBar/Titlescreen.use_parent_material = true
			$CenterContainer/RightBar/restart.use_parent_material = false
			show.position.y = 603
			show.position.x = 329
			if Inputs.just_key_enter:
				if global.level == "hub":
					pass
				if !global.level == "hub":
					restartlevel()
		if selection == 4:
			$CenterContainer/RightBar/Resume.use_parent_material = true
			$CenterContainer/RightBar/Settings.use_parent_material = true
			$CenterContainer/RightBar/Titlescreen.use_parent_material = false
			$CenterContainer/RightBar/restart.use_parent_material = true
			show.position.y = 593
			show.position.x = 459
			if Inputs.just_key_enter:
				if canselect:
					objplayer.changestate("Nothing")
					$AnimationPlayer.play("fadein")
					canselect = false
					$song.stop()
					canpause = false
					yield(get_tree().create_timer(1.0), "timeout")
					get_tree().paused = !get_tree().paused
					music.stopmusic()
					global.panic = false
					music.stoppanic()
					global.emit_signal("reset")
					global.room_goto("res://assets/scenes/newTitle.tscn", "door1")
					global.bosslevel = 0
					$AnimationPlayer.play("reset")
					paused = !paused
					self.visible = !self.visible
					canpause = true
					canselect = true
		
		
		
func restartlevel():
	global.emit_signal("reset")
	global.panic = false
	objplayer.reset()
	if presobjs.player2:
		presobjs.player2.reset()
	$AnimationPlayer.play("reset")
	paused = false
	self.visible = false
	canselect = true
	get_tree().paused = false
	$song.stop()
	ct._treset()
	music.musicaudio.play()
	global.room_goto(global.restartlevel, global.restartdoor)
		
		
func oldrestartlevel():
	global.emit_signal("reset")
	global.panic = false
	objplayer.reset()
	if presobjs.player2:
		presobjs.player2.reset()
	$AnimationPlayer.play("reset")
	paused = !paused
	self.visible = !self.visible
	canselect = true
	get_tree().paused = !get_tree().paused
	$song.stop()
	ct._treset()
	music.musicaudio.play()
	global.targetdoor = "door1"
	if is_instance_valid(presobjs.get_node("evilguy")):
			presobjs.killtod()
	if global.level == "snow":
		global.room_goto("res://assets/scenes/snow/snow_1.tscn", "door1")
	if global.level == "entrance":
		global.room_goto("res://assets/scenes/entrance/entrance_1.tscn", "door1")
	if global.level == "city":
		global.room_goto("res://assets/scenes/city/city_1.tscn", "door1")
	if global.level == "sispus":
		global.room_goto("res://assets/scenes/misc/sisyphus.tscn", "door1")
	if global.level == "boss":
		global.room_goto("res://assets/scenes/boss_test.tscn", "door1")
	
	

	
	


