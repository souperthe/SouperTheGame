extends Control

var settingson = 0
var selection = 1
var canselect = false

enum menus {
	main,
	video,
	inputs,
	sound,
	game
}

var selectedmenu = menus.main
var inputselection = 0
var inputcanselect = true
var pressanykey = false
var chooseninput
var modifyinginput = "attack"
var videoselection = 0

var resolutions = []
var resolutions_selection = 0
var resolutions_amount = 0

var game_selection = 0
var sound_selection = 0
var soundselected = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	resolutions_amount = global.resolutions.size()
	$Main.visible = true
	$Video.visible = true
	$Game.visible = true
	$Inputs.visible = true
	$Sound.visible = true
	pass # Replace with function body.

func reset():
	inputselection = 1
	videoselection = 0
	selection = 1000
	selectedmenu = menus.main
	canselect = false
	$Timer.start()
	pressanykey = false
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var pointer = $Main/pointer
	if settingson:
		$Main.visible = selectedmenu == menus.main
		$Video.visible = selectedmenu == menus.video
		$Game.visible = selectedmenu == menus.game
		$Inputs.visible = selectedmenu == menus.inputs
		$Sound.visible = selectedmenu == menus.sound
		match(selectedmenu):
			menus.main:
				pass
			menus.video:
				var pointerthing = $Video/Pointerglove
				$Video/RichTextLabel5.bbcode_text = str("Resolution: ", OS.window_size)
				$Video/VSYNC.bbcode_text = str("Vsync: ", OS.vsync_enabled)
				$Video/FULLSCREEN.bbcode_text = str("Fullscreen: ", OS.window_fullscreen)
				$Video/SHOWHUD.bbcode_text = str("Show HUD: ", global.settingshowhud)
				if Inputs.just_key_down:
					videoselection += 1
					$AudioStreamPlayer.play()
				if Inputs.just_key_up:
					videoselection -= 1
					$AudioStreamPlayer.play()
				var cantchange = OS.window_fullscreen or OS.window_maximized
				match(cantchange):
					true:
						$Video/RichTextLabel5.modulate = Color8(128,128,128,255)
					false:
						$Video/RichTextLabel5.modulate = Color8(255,255,255,255)
				var video_offset = Vector2(-55, 27)
				match(videoselection):
					0:
						pointerthing.position = $Video/RichTextLabel5.rect_position + video_offset
						if !OS.window_fullscreen and !OS.window_maximized:
							if Inputs.just_key_left:
								global.resolutions_selection += 1
								$AudioStreamPlayer.play()
							if Inputs.just_key_right:
								global.resolutions_selection -= 1
								$AudioStreamPlayer.play()
							if global.resolutions_selection < 1:
								global.resolutions_selection = resolutions_amount
							if global.resolutions_selection > resolutions_amount:
								global.resolutions_selection = 1
							OS.window_size = global.resolutions[global.resolutions_selection - 1]
					1:
						pointerthing.position = $Video/VSYNC.rect_position + video_offset
						if Inputs.just_key_jump:
							OS.vsync_enabled = !OS.vsync_enabled
							$sillysfx.sound()
					2:
						pointerthing.position = $Video/FULLSCREEN.rect_position + video_offset
						if Inputs.just_key_jump:
							OS.window_fullscreen = !OS.window_fullscreen
							$sillysfx.sound()
							if !OS.window_fullscreen:
								global.resolutions_selection = 4
								OS.window_size = global.resolutions[global.resolutions_selection - 1]
					3:
						pointerthing.position = $Video/SHOWHUD.rect_position + video_offset
						if Inputs.just_key_jump:
							global.settingshowhud = !global.settingshowhud
							$sillysfx.sound()
				#OS.window_size = OS.get_screen_size() / 2
				if videoselection < 0:
					videoselection = 3
				if videoselection > 3:
					videoselection = 0
				if Inputs.just_key_pause or Inputs.just_key_attack:
					selectedmenu = menus.main
					$sillysfx.sound()
					SaveSystem.set_var("video_fullscreen", OS.window_fullscreen)
					SaveSystem.set_var("window_resolution", global.resolutions_selection - 1)
					SaveSystem.save()
			menus.game:
				var pointerthing2 = $Game/Pointerglove
				var pointer_offset = Vector2(-55, 27)
				$Game/shake.bbcode_text = str("Shake effects: ", global.shake_effects)
				$Game/hitoff.bbcode_text = str("Hit knockback: ", global.hit_offset)
				$Game/fallcutscene.bbcode_text = str("Fall Cutscene: ", global.fall_cutscene)
				$Game/fallcutscene2.bbcode_text = str("Speedrun Timer: ", global.speedruntimer)
				match(game_selection):
					0:
						pointerthing2.position = $Game/shake.rect_position + pointer_offset
						if Inputs.just_key_jump:
							global.shake_effects = !global.shake_effects
							$sillysfx.sound()
					1:
						pointerthing2.position = $Game/hitoff.rect_position + pointer_offset
						if Inputs.just_key_jump:
							global.hit_offset = !global.hit_offset
							$sillysfx.sound()
					2:
						pointerthing2.position = $Game/fallcutscene.rect_position + pointer_offset
						if Inputs.just_key_jump:
							global.fall_cutscene = !global.fall_cutscene
							$sillysfx.sound()
					3:
						pointerthing2.position = $Game/fallcutscene2.rect_position + pointer_offset
						if Inputs.just_key_jump:
							global.speedruntimer = !global.speedruntimer
							$sillysfx.sound()
				if Inputs.just_key_down:
					game_selection += 1
					$AudioStreamPlayer.play()
				if Inputs.just_key_up:
					game_selection -= 1
					$AudioStreamPlayer.play()
				if game_selection < 0:
					game_selection = 3
				if game_selection > 3:
					game_selection = 0
				if Inputs.just_key_pause or Inputs.just_key_attack:
					selectedmenu = menus.main
					SaveSystem.set_var("speedruntimer",global.speedruntimer)
					SaveSystem.set_var("fall_cutscene",global.fall_cutscene)
					SaveSystem.set_var("shake_effects",global.shake_effects)
					SaveSystem.set_var("hit_offset",global.hit_offset)
					$sillysfx.sound()
			menus.inputs:
				var selectoffset = Vector2(360,30)
				var selectpointer = $Inputs/thing/Pointerglove
				$Inputs/pressanykey.visible = pressanykey
				if !inputselection == 10:
					if Inputs.just_key_jump:
						#$Inputs/pressanykey.visible = true
						pressanykey = true
				if pressanykey:
					#$Inputs/pressanykey.visible = true
					$Inputs/pressanykey/modfying.bbcode_text = str("[center]Modfying... ", modifyinginput)
					$Inputs/pressanykey/RichTextLabel.bbcode_text = str("[center]", OS.get_scancode_string(chooseninput))
					if Inputs.just_key_enter:
						$sillysfx.sound()
						#$Inputs/pressanykey.visible = false
						match(modifyinginput):
							"attack":
								Inputs.input_attack = chooseninput
								SaveSystem.set_var("key_attack", chooseninput)
							"jump":
								Inputs.input_jump = chooseninput
								SaveSystem.set_var("key_jump", chooseninput)
							"dash":
								Inputs.input_dash = chooseninput
								SaveSystem.set_var("key_dash", chooseninput)
							"shoot":
								Inputs.input_shoot = chooseninput
								SaveSystem.set_var("key_shoot", chooseninput)
							"pause":
								Inputs.input_pause = chooseninput
								SaveSystem.set_var("key_pause", chooseninput)
							"up":
								Inputs.input_up = chooseninput
								SaveSystem.set_var("key_up", chooseninput)
							"down":
								Inputs.input_down = chooseninput
								SaveSystem.set_var("key_down", chooseninput)
							"left":
								Inputs.input_left = chooseninput
								SaveSystem.set_var("key_left", chooseninput)
							"right":
								Inputs.input_right = chooseninput
								SaveSystem.set_var("key_right", chooseninput)
						pressanykey = false
				match(inputselection):
					1:
						modifyinginput = "attack"
						selectpointer.position = $Inputs/thing/attack.rect_position + selectoffset
					2:
						modifyinginput = "jump"
						selectpointer.position = $Inputs/thing/jump.rect_position + selectoffset
					3:
						modifyinginput = "dash"
						selectpointer.position = $Inputs/thing/dash.rect_position + selectoffset
					4:
						modifyinginput = "shoot"
						selectpointer.position = $Inputs/thing/shoot.rect_position + selectoffset
					5:
						modifyinginput = "up"
						selectpointer.position = $Inputs/thing/up.rect_position + selectoffset
					6:
						modifyinginput = "down"
						selectpointer.position = $Inputs/thing/down.rect_position + selectoffset
					7:
						modifyinginput = "left"
						selectpointer.position = $Inputs/thing/left.rect_position + selectoffset
					8:
						modifyinginput = "right"
						selectpointer.position = $Inputs/thing/right.rect_position + selectoffset
					9:
						modifyinginput = "pause"
						selectpointer.position = $Inputs/thing/pause.rect_position + selectoffset
					10:
						selectpointer.position = $Inputs/thing/reset.rect_position + selectoffset + Vector2(-150, 0)
						if Inputs.just_key_enter or Inputs.just_key_jump:
							$sillysfx.sound()
							Inputs.input_jump = KEY_Z
							Inputs.input_attack = KEY_X
							Inputs.input_dash = KEY_SHIFT
							Inputs.input_shoot = KEY_C
							Inputs.input_up = KEY_UP
							Inputs.input_down = KEY_DOWN
							Inputs.input_left = KEY_LEFT
							Inputs.input_right = KEY_RIGHT
							Inputs.input_pause = KEY_ESCAPE
							SaveSystem.set_var("key_down", KEY_DOWN)
							SaveSystem.set_var("key_left", KEY_LEFT)
							SaveSystem.set_var("key_right", KEY_RIGHT)
							SaveSystem.set_var("key_up", KEY_UP)
							SaveSystem.set_var("key_jump", KEY_Z)
							SaveSystem.set_var("key_shoot", KEY_C)
							SaveSystem.set_var("key_dash", KEY_SHIFT)
							SaveSystem.set_var("key_pause", KEY_ESCAPE)
							SaveSystem.set_var("key_enter", KEY_ENTER)
				if inputselection > 10:
					inputselection = 1
				if inputselection < 1:
					inputselection = 10
				if !pressanykey and Inputs.just_key_up:
					inputselection -= 1
					$AudioStreamPlayer.play()
				if !pressanykey and Inputs.just_key_down:
					inputselection += 1
					$AudioStreamPlayer.play()
				if !pressanykey and (Inputs.just_key_pause or Inputs.just_key_attack):
					selectedmenu = menus.main
					SaveSystem.set_var("key_down", Inputs.input_down)
					SaveSystem.set_var("key_left", Inputs.input_left)
					SaveSystem.set_var("key_right", Inputs.input_right)
					SaveSystem.set_var("key_up", Inputs.input_up)
					SaveSystem.set_var("key_jump", Inputs.input_jump)
					SaveSystem.set_var("key_shoot", Inputs.input_shoot)
					SaveSystem.set_var("key_dash", Inputs.input_dash)
					SaveSystem.set_var("key_pause", Inputs.input_pause)
					$sillysfx.sound()
			menus.sound:
				var pointer2 = $Sound/Pointerglove
				var offset = 5
				if Inputs.just_key_right:
					if !soundselected:
						sound_selection += 1
						$AudioStreamPlayer.play()
				if Inputs.just_key_left:
					if !soundselected:
						sound_selection -= 1
						$AudioStreamPlayer.play()
				if sound_selection > 2:
					sound_selection = 0
				if sound_selection < 0:
					sound_selection = 2
				pointer2.visible = !soundselected
				pointer2.position.y = $Sound/sfxprogess.rect_position.y - 390
				$Sound/sfxprogess.value = global.sfxvolume * 2.5
				$Sound/masterprogress.value = global.mastervolume * 2.5
				$Sound/musicprogress.value = global.musicvolume * 2.5
				match(sound_selection):
					0:
						pointer2.position.x = $Sound/sfxprogess.rect_position.x + offset
						#pointer2.position.y = $Sound/sfxprogess.rect_position.y - 360
					1:
						pointer2.position.x = $Sound/masterprogress.rect_position.x + offset
					2:
						pointer2.position.x = $Sound/musicprogress.rect_position.x + offset
				if Inputs.just_key_jump:
					soundselected = true
					$sillysfx.sound()
				var changeamount = 0.2
				if soundselected:
					match(sound_selection):
						0:
							if Inputs.key_up:
								global.sfxvolume += changeamount
							if Inputs.key_down:
								global.sfxvolume -= changeamount
							if global.sfxvolume > 0:
								global.sfxvolume = 0
							if global.sfxvolume < -88:
								global.sfxvolume = -88
						1:
							if Inputs.key_up:
								global.mastervolume += changeamount
							if Inputs.key_down:
								global.mastervolume -= changeamount
							if global.mastervolume > 0:
								global.mastervolume = 0
							if global.mastervolume < -88:
								global.mastervolume = -88
						2:
							if Inputs.key_up:
								global.musicvolume += changeamount
							if Inputs.key_down:
								global.musicvolume -= changeamount
							if global.musicvolume > 0:
								global.musicvolume = 0
							if global.musicvolume < -88:
								global.musicvolume = -88
					if Inputs.just_key_attack:
						soundselected = false
						$sillysfx.sound()
				if Inputs.just_key_pause or Inputs.just_key_attack:
					if !soundselected:
						selectedmenu = menus.main
						SaveSystem.set_var("master_volume",global.mastervolume)
						SaveSystem.set_var("sfx_volume",global.sfxvolume)
						SaveSystem.set_var("music_volume",global.musicvolume)
						$sillysfx.sound()
	if canselect and settingson and selectedmenu == menus.main:
		if selection > 4:
			selection = 1
		if selection < 1:
			selection = 4
		if Inputs.just_key_up:
			selection -= 1
			$AudioStreamPlayer.play()
		if Inputs.just_key_down:
			selection += 1
			$AudioStreamPlayer.play()
		var offset = Vector2(20,18)
		match(selection):
			1:
				pointer.rect_position = $Main/RichTextLabel.rect_position + offset
			2:
				pointer.rect_position = $Main/RichTextLabel2.rect_position + offset
			3:
				pointer.rect_position = $Main/RichTextLabel3.rect_position + offset
			4:
				pointer.rect_position = $Main/RichTextLabel4.rect_position + offset
		if Inputs.just_key_jump:
			$sillysfx.sound()
			match(selection):
				1:
					selectedmenu = menus.video
				2:
					selectedmenu = menus.inputs
					inputselection = 1
				3:
					selectedmenu = menus.sound
				4:
					selectedmenu = menus.game
			
				
#	pass


func _on_Timer_timeout():
	canselect = true
	pass # Replace with function body.
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER:
			chooseninput = event.scancode
