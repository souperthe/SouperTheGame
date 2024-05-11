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

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reset():
	inputselection = 1
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
				if Inputs.just_key_pause or Inputs.just_key_attack:
					selectedmenu = menus.main
					$sillysfx.sound()
			menus.game:
				if Inputs.just_key_pause or Inputs.just_key_attack:
					selectedmenu = menus.main
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
							"jump":
								Inputs.input_jump = chooseninput
							"dash":
								Inputs.input_dash = chooseninput
							"shoot":
								Inputs.input_shoot = chooseninput
							"pause":
								Inputs.input_pause = chooseninput
							"up":
								Inputs.input_up = chooseninput
							"down":
								Inputs.input_down = chooseninput
							"left":
								Inputs.input_left = chooseninput
							"right":
								Inputs.input_right = chooseninput
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
					$sillysfx.sound()
			menus.sound:
				if Inputs.just_key_pause or Inputs.just_key_attack:
					selectedmenu = menus.main
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
