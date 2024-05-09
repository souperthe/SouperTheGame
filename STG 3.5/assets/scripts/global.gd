extends Node


var current_scene = null

var panic = false
var targetdoor = "door1"
var hardmode = false
var combo = 0
var publicbuild = 0
var sisyphusbuild = 0
var score = 0
var timedlevel = false
var windowsize = Vector2(960,540)
var secretsfound = 0
var doortime = 0.3
var level = "none"
var lockcamera = false
var combobreaks = 0
var moneybag = false
var combodropped = false
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
var greenkey = false
var camerarotamount = 3
var rank = "5/5"
var treasure = false
var escapeexited = false
var camera
var windowtitle = "Souper The Game"
var hidehud = false
var hidehudtween = false
var cinematicbar = false
var phonescreen = false
var oldtodmode = false

var whiteflash = preload("res://assets/objects/flash.tscn")
var SaveManager = ConfigFile.new()
var SaveData = SaveManager.load("user://saveData.ini")

onready var infotext = $infolayer/info

var leveltime = 0
var playingas = "Souper"
var countdown = true
var highestcombo = 0
var previouscombo = 0
var timet = "2136723181"


signal scenechanged 
signal reset





func _ready():
	infotext.rect_position.y = 560
	#AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	#OS.window_size.x = 480 /2
	#OS.window_size.y = 270 / 2
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
	
func _physics_process(delta):
	#OS.window_size.x = lerp(OS.window_size.x, windowsize.x, 5 * delta)
	#OS.window_size.y = lerp(OS.window_size.y, windowsize.y, 5 * delta)
	var time = global.leveltime
	var minutes := int(time / 60)
	var seconds := fmod(time, 60)
	var _milliseconds := fmod(time, 1) * 100
	timet = (str("%01d:%02d" % [minutes, seconds]))
	combocheck()
	if countdown:
		leveltime += delta
	$infolayer/info.visible = !hidehud or !cutscene
	if !OS.has_feature("32") and !OS.has_feature("Andriod"):
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
		
		
func combocheck():
	if !combo == previouscombo:
		if combo > highestcombo:
			highestcombo = combo
		previouscombo = combo


func _on_Timer_timeout():
	$comboend.play()
	addscore(combo)
	combodropped = true
	combo = 0
	combobreaks += 1
	#combocheck()
	
func update_activity() -> void:
	var activity = Discord.Activity.new()
	activity.set_type(Discord.ActivityType.Playing)
	if roomhandle.currentscene.name ==  "menu":
		activity.set_details("In the Menus")
	if !roomhandle.currentscene.name ==  "menu":
		if global.hardmode:
			activity.set_details("In a level, playing tod mode.")
		if !global.hardmode:
			activity.set_details("In a level, playing normally.")
	if roomhandle.currentscene.name ==  "menu":
		activity.set_state("The most epic game of all time..")
	if !roomhandle.currentscene.name ==  "menu":
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
	assets.set_small_text(str("Playing as ", playingas))
	
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
	
func playsmallnew():
	$collectnew.play()
	
func escapeplaysmall():
	$collectescapesmall.play()
	
func roomstart():
	if roomhandle.currentscene.name == "entrance":
		rankworks = 1
		srank = 13000
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
	
#func sfx3d(x,y,sound):
	#playcock(x,y,sound)
	
func playsound(pos,sound):
	var thing = preload("res://assets/objects/cocking.tscn")
	var ghost: AudioStreamPlayer2D = thing.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.stream = load(sound)
	ghost.position = pos
	ghost.play()
	#pass
	
func ranks():
	if score > drank:
		rank = "1/5"
	if score > crank:
		rank = "2/5"
	if score > brank:
		rank = "3/5"
	if score > arank:
		rank = "4/5"
	if score > srank and treasure and moneybag and secretsfound > 3:
		if !laps == 0:
			if !combodropped:
				rank = "6/5"
			if combodropped:
				rank = "5/5"
			
			
func instance_create(x, y, scene):
	var loadedscene = load(scene)
	var id = loadedscene.instance()
	roomhandle.currentscene.add_child(id)
	id.position = Vector2(x, y)
	return id
			
func get_instance_level(node):
	var instancenode = roomhandle.currentscene.get_node_or_null(node)
	return instancenode
			
func delete_tile_at(position):
	var level_tilemap = get_instance_level("TileMap")
	if level_tilemap != null:
		var local_position = level_tilemap.to_local(position)
		var tile_position = level_tilemap.world_to_map(local_position)
		level_tilemap.set_cell(tile_position.x, tile_position.y, -1)

func info(text,time):
	$infolayer/infoanimation.play("enter")
	$infolayer/info.bbcode_text = str("[center]", text)
	$infolayer/infotime.wait_time = time
	$infolayer/infotime.start()


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
	
	

	
	
	



	


func _on_infotime_timeout():
	$infolayer/infoanimation.play("leave")
	pass # Replace with function body.
