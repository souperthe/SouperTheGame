extends Node


var current_scene = null

var panic = false
var targetdoor = "door1"
var hardmode = false
var combo = 0
var publicbuild = 0
var sisyphusbuild = 0
var score = 0
var level = "none"
var restartlevel = "res://assets/scenes/test.tscn"
var restartdoor = targetdoor
var bosslevel = 0
var camerazoom = 1
var camerasmoothing = false
var cameraspeed = 5
var showcolloisions = true
var panicdone = false
var cutscene = false
var baddieroom = []
var collectablesroom = []
var othersroom = []
var escaperoom = []
var targetRoom2 = "res://assets/scenes/test.tscn"
onready var fill = $panicfill
onready var combotimer = $Timer
export var loadscene: PackedScene
var laps = 0
var rankworks = 0
var srank = 0
var arank = 0
var brank = 0
var crank = 0
var drank = 0
var camerarotamount = 3
var rank = "5/5"
var treasure = false
var escapeexited = false
var camera
var windowtitle = "Souper The Game"
var hidehud = false
var hidehudtween = false
var cinematicbar = false

var whiteflash = preload("res://assets/objects/flash.tscn")
var SaveManager = ConfigFile.new()
var SaveData = SaveManager.load("user://saveData.ini")


signal scenechanged 
signal reset





func _ready():
	#AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
	
func _physics_process(_delta):
	update_activity()
	runcinematic()
	if score < 0:
		score += abs(score)
	roomstart()
	if rankworks:
		ranks()
	#print(combo)
	if panic == true:
		music.playescape()
	if panic == false:
		music.stoppanic()
	pass
	
func runcinematic():
	if cinematicbar:
		$CanvasLayer/ColorRect.rect_position.y = lerp($CanvasLayer/ColorRect.rect_position.y, -88, 0.1)
		$CanvasLayer/ColorRect2.rect_position.y = lerp($CanvasLayer/ColorRect2.rect_position.y, 478, 0.1)
	if !cinematicbar:
		$CanvasLayer/ColorRect.rect_position.y = lerp($CanvasLayer/ColorRect.rect_position.y, -152, 0.1)
		$CanvasLayer/ColorRect2.rect_position.y = lerp($CanvasLayer/ColorRect2.rect_position.y, 541, 0.1)
	
	
func addcombo():
	objplayer.combo.startcountdown()
	combo += 1
	$Timer.start()
	
func resetcombo():
	if !combo == 0:
		$Timer.start()
		objplayer.combo.startcountdown()

func congratplay():
	$congrat.play()
	objplayer.win()
	music.stopmusic()
	if sisyphusbuild:
		$winner/image.visible = true
	if !sisyphusbuild:
		$winner/image.visible = false


func _on_Timer_timeout():
	addscore(combo)
	combo = 0
	
func update_activity() -> void:
	var activity = Discord.Activity.new()
	activity.set_type(Discord.ActivityType.Playing)
	if get_tree().current_scene.name == "menu":
		activity.set_details("In the Menus")
	if !get_tree().current_scene.name == "menu":
		if global.hardmode:
			activity.set_details("In a level with Tod mode.")
		if !global.hardmode:
			activity.set_details("In a level with standard.")
	if get_tree().current_scene.name == "menu":
		activity.set_state("The most epic game of all time..")
	if !get_tree().current_scene.name == "menu":
		if global.hidehud:
			activity.set_state("The most epic game of all time..")
		if !global.hidehud:
			if global.bosslevel:
				activity.set_state(str("Health: ", objplayer.bosshealth))
			if !global.bosslevel:
				activity.set_state(str("Rank: ", global.rank, ",", "  Score: ", global.score, ", ", "Combo: ", global.combo))

	var assets = activity.get_assets()
	assets.set_large_image("big")
	assets.set_large_text("Souper The Game")
	assets.set_small_image("soupercon")
	assets.set_small_text(str("Playing as ", "Souper"))
	
	var _timestamps = activity.get_timestamps()
	#timestamps.set_start(OS.get_unix_time() + 100)
	#timestamps.set_end(OS.get_unix_time() + 500)

	var result = yield(Discord.activity_manager.update_activity(activity), "result").result
	if result != Discord.Result.Ok:
		push_error(str(result))
	
func room_goto(targetRoom, targetDoor):
	#loadscene = load(targetRoom)
	#get_tree().change_scene_to(loadscene)
	targetdoor = targetDoor
	targetRoom2 = targetRoom
	roomhandle.scenegoto(targetRoom)
	objplayer.gototargetdoor()
	presobjs.player2gototargetdoor()
	emit_signal("scenechanged")
	music.musicvolume = 2
	
func brah():
	emit_signal("reset")
	
func addscore(amount):
	score += amount
	
func playsmall():
	$collectsmall.play()
	
func escapeplaysmall():
	$collectescapesmall.play()
	
func roomstart():
	if get_tree().current_scene.name == "entrance":
		rankworks = 1
		srank = 8420
		arank = (global.srank - (global.srank / 4))
		brank = (global.srank - ((global.srank / 4) * 2))
		crank = (global.srank - ((global.srank / 4) * 3))
		rank = "1/5"
	
	


func _on_panicfill_timeout():
	panicdone = true
	fill.stop()
	#OS.alert("message", "title")
	pass # Replace with function body.
	
func makeflash():
	var ghost: CanvasLayer = whiteflash.instance()
	add_child(ghost)
	
func ranks():
	if score > drank:
		rank = "1/5"
	if score > crank:
		rank = "2/5"
	if score > brank:
		rank = "3/5"
	if score > arank:
		rank = "4/5"
	if score > srank and treasure:
		if laps == 0:
			rank = "5/5"
		if !laps == 0:
			rank = "6/5"
			



#save data shit, i DO not wanna code this shit atall
#nvm scratch that i have a better method
#nvm again i have ANOTHER god damn method
#i hate this engine sometimes
## ACTUAL SAVE DATA SHIT ##
#var savepath = "user://stgdata.save"
var savepath = "user://stgdata.dat"

func write_save(data):
	var file = File.new()
	file.open(savepath, File.WRITE)
	file.store_var(data)
	file.close()
	
	
func load_save():
	var file = File.new()
	var _content
	file.open(savepath, File.READ)
	_content = file.get_var()
	file.close()
	return _content
	
	
	
	



	
