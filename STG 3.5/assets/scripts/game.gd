extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/RichTextLabel.queue_free()
	global.room_goto("res://assets/scenes/splash_screen.tscn", "door1")
	if !SaveSystem.has("firstplayed"):
		SaveSystem.delete_all()
		defaults()
	#######
	OS.window_fullscreen = SaveSystem.get_var("video_fullscreen")
	global.mastervolume = SaveSystem.get_var("master_volume",0)
	global.sfxvolume = SaveSystem.get_var("sfx_volume",0)
	global.musicvolume = SaveSystem.get_var("music_volume",0)
	###
	Inputs.key_down = SaveSystem.get_var("key_down")
	Inputs.key_up = SaveSystem.get_var("key_up")
	Inputs.key_left = SaveSystem.get_var("key_left")
	Inputs.key_right = SaveSystem.get_var("key_right")
	
	Inputs.key_jump = SaveSystem.get_var("key_jump")
	Inputs.key_shoot = SaveSystem.get_var("key_shoot")
	Inputs.key_dash = SaveSystem.get_var("key_dash")
	Inputs.key_pause = SaveSystem.get_var("key_pause")
	#Inputs.key_down = SaveSystem.get_var("key_down")
	
	global.speedruntimer = SaveSystem.get_var("speedruntimer",false)
	global.fall_cutscene = SaveSystem.get_var("fall_cutscene",true)
	global.shake_effects = SaveSystem.get_var("shake_effects",true)
	global.hit_offset = SaveSystem.get_var("hit_offset",true)
	
	OS.window_size = global.resolutions[SaveSystem.get_var("window_resolution")]
	SaveSystem.save()
	if !OS.window_fullscreen:
		OS.center_window()
	queue_free()
	pass # Replace with function body.

func defaults():
	SaveSystem.set_var("video_fullscreen", true)
	SaveSystem.set_var("window_resolution", 1)
	SaveSystem.set_var("master_volume", 0)
	SaveSystem.set_var("sfx_volume", 0)
	SaveSystem.set_var("music_volume", 0)
	SaveSystem.set_var("played_demo", true)
	SaveSystem.set_var("firstplayed", true)
	##########
	SaveSystem.set_var("key_down", Inputs.key_down)
	SaveSystem.set_var("key_left", Inputs.key_left)
	SaveSystem.set_var("key_right", Inputs.key_right)
	SaveSystem.set_var("key_up", Inputs.key_up)
	##
	SaveSystem.set_var("key_jump", Inputs.key_jump)
	SaveSystem.set_var("key_shoot", Inputs.key_shoot)
	SaveSystem.set_var("key_dash", Inputs.key_dash)
	SaveSystem.set_var("key_pause",Inputs.key_pause)
	#SaveSystem.set_var("key_enter", Inputs.key_enter)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
