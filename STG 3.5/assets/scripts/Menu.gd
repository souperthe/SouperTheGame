extends Control


onready var circle_transition = $circletrans
onready var anim = $AnimationPlayer
onready var anim2 = $AnimationPlayer2
onready var haha = $start
onready var butt = $start2
# Declare member variables here. Examples:
var pressed = false
var username
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("RESET")
	objplayer.gooffscreen()
	music.playtitle()
	anim2.play("fademusic")
	ct._tout()
	anim.play("presstart")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and !pressed:
		if not global.sisyphusbuild:
			butt.play()
			anim.play("pressed")
			yield(get_tree().create_timer(1.0), "timeout")
			ct._tin()
			yield(get_tree().create_timer(1.0), "timeout")
			get_tree().change_scene("res://assets/scenes/level_select.tscn")
		if global.sisyphusbuild:
			music.stopmusic()
			butt.play()
			anim.play("pressed")
			yield(get_tree().create_timer(1.0), "timeout")
			ct._tin()
			yield(get_tree().create_timer(1.0), "timeout")
			ct._tout()
			global.room_goto("res://assets/scenes/misc/sisyphus.tscn", "door1")
			objplayer.respawn()
			objplayer.defaultdir()
			objplayer.exitdoor()
		#if OS.is_debug_build():
			#butt.play()
			#anim.play("pressed")
			#yield(get_tree().create_timer(1.0), "timeout")
			#ct._tin()
			#yield(get_tree().create_timer(1.0), "timeout")
			#get_tree().change_scene("res://assets/scenes/level_select.tscn")
		#if not OS.is_debug_build():
			#music.stopmusic()
			#butt.play()
			#anim.play("pressed")
			#yield(get_tree().create_timer(1.0), "timeout")
			#ct._tin()
			#yield(get_tree().create_timer(1.0), "timeout")
			#get_tree().change_scene("res://assets/scenes/city/city_1.tscn")
		pressed = true


func _play():
	ct._tin()
