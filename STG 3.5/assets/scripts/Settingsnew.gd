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

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reset():
	selection = 1
	selectedmenu = menus.main
	canselect = false
	$Timer.start()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
			menus.game:
				if Inputs.just_key_pause or Inputs.just_key_attack:
					selectedmenu = menus.main
			menus.inputs:
				if Inputs.just_key_pause or Inputs.just_key_attack:
					selectedmenu = menus.main
			menus.sound:
				if Inputs.just_key_pause or Inputs.just_key_attack:
					selectedmenu = menus.main
	if canselect and settingson and selectedmenu == menus.main:
		if selection > 4:
			selection = 1
		if selection < 1:
			selection = 4
		if Inputs.just_key_up:
			selection -= 1
		if Inputs.just_key_down:
			selection += 1
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
		if Inputs.just_key_enter or Inputs.just_key_jump:
			match(selection):
				1:
					selectedmenu = menus.video
				2:
					selectedmenu = menus.inputs
				3:
					selectedmenu = menus.sound
				4:
					selectedmenu = menus.game
			
				
#	pass


func _on_Timer_timeout():
	canselect = true
	pass # Replace with function body.
