extends Node

onready var escapeaudio = $escapemusic
onready var musicaudio = $Music
var song = load("res://assets/sound/music/ogg/mus_title.ogg")
var panicplaying = false
var entrancesong = load("res://assets/sound/music/ogg/mus_house.ogg")
var failure = load("res://assets/sound/sfx/sfx_failure.wav")
var imaginesong = load("res://assets/sound/music/ogg/mus_onemustimagine.ogg")
var boss1 = load("res://assets/sound/music/ogg/mus_boss1.ogg")
var city = load("res://assets/sound/music/ogg/mus_citynew.ogg")
var none
var scary = load("res://assets/sound/music/ogg/mus_scary.ogg")
var snow = load("res://assets/sound/music/ogg/mus_snow.ogg")
var lap1 = load("res://assets/sound/music/ogg/mus_escapenew.ogg")
var lap2 = load("res://assets/sound/music/ogg/mus_lapping.ogg")
var old = load("res://assets/ignore/loop1.mp3")
var musicvolume = 2
var playmusic = true
var temp = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func playtitle():
	song = load("res://assets/sound/music/ogg/mus_title.ogg")
	$Music.stream = song
	$Music.play()
	
func stopmusic():
	$Music.stop()
	$escapemusic.stop()
	temp = 0
	
func playsnow():
	song = load("res://assets/sound/music/mus_snow.wav")
	$Music.stream = song
	$Music.play()
	
func playcity():
	song = load("res://assets/sound/music/mus_city.wav")
	$Music.stream = song
	$Music.play()

func playretros():
	song = load("res://assets/sound/music/ogg/mus_retros.ogg")
	$Music.stream = song
	$Music.play()
	
	
func playtod():
	song = load("res://assets/sound/music/ogg/mus_todmode.ogg")
	$Music.stream = song
	$Music.play()
	
func playentrance():
	song = load("res://assets/sound/music/mus_souper_entrance.wav")
	$Music.stream = song
	$Music.play()
	
func playescape():
	if global.panic == true and panicplaying == false and playmusic:
		$escapemusic.stream = lap1
		$escapemusic.play()
		$Music.volume_db = -80
		panicplaying = true
		
func stoppanic():
	panicplaying = false
	$escapemusic.stop()
	$Music.volume_db = musicvolume
	
func _process(_delta):
	if playmusic:
		domusic()
		if !$Music.stream == null:
			temp = $Music.get_playback_position( )
	
func domusic():
	if global.panic:
		if !global.laps == 0:
			if !$escapemusic.stream == lap2:
				$escapemusic.stream = lap2
				$escapemusic.play()
	#do stuff
	if get_tree().current_scene.name == "scary":
		$Music.stream = null
	if get_tree().current_scene.name == "oldsouper":
			if !$Music.stream == old:
				$Music.stream = old
				$Music.play()
	if get_tree().current_scene.name == "snow":
			if !$Music.stream == snow:
				$Music.stream = snow
				$Music.play()
	if get_tree().current_scene.name == "entrance":
		if !$Music.stream == entrancesong:
			$Music.stream = entrancesong
			$Music.play()
			$Music.seek(float(temp))
	if get_tree().current_scene.name == "imagine":
		if !$Music.stream == imaginesong:
			$Music.stream = imaginesong
			$Music.play()
	if get_tree().current_scene.name == "gbj":
		if !$Music.stream == failure:
			$Music.stream = failure
			$Music.play()
	if get_tree().current_scene.name == "boss1":
		if !$Music.stream == boss1:
			$Music.stream = boss1
			$Music.play()
	if get_tree().current_scene.name == "city":
		if !$Music.stream == city:
			$Music.stream = city
			$Music.play()

	
	
