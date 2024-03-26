extends Control

onready var bg = $bg
onready var pointer = $pointer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selection = 1
var canselect = 0
var settingson = 0
var selected = 0
var volume = 0
var volumenabled = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$option2/Control/arrow.play("default")
	$option2/Control/arrow2.play("default")
	pass # Replace with function body.
	
	
func _process(_delta):
	$option2/Control/arrow.visible = volumenabled
	$option2/Control/arrow2.visible = volumenabled
	move_pointer()
	dothings()
	if settingson:
		inputs()
		if volumenabled:
			volumecontrol()
	
func dothings():
	if selected == 0:
		$pointer/pointeranim.play("pointing")
	if selected == 1:
		$pointer/pointeranim.play("notselect")
	if OS.window_fullscreen == false:
		$option1/box/checkbox.play("nocheck")
	if OS.window_fullscreen == true:
		$option1/box/checkbox.play("checked")
	if OS.vsync_enabled == false:
		$option3/box/checkbox.play("nocheck")
	if OS.vsync_enabled == true:
		$option3/box/checkbox.play("checked")
	
	
func volumecontrol():
	$option2.active()

	

func playconfirm():
	$confirm.play()

func move_pointer():
	if selection == 1:
		pointer.rect_position.x = 83
		pointer.rect_position.y = 173
	if selection == 2:
		pointer.rect_position.x = 632
		pointer.rect_position.y = 173
	if selection == 3:
		pointer.rect_position.x = 83
		pointer.rect_position.y = 403
	if selection < 1:
		selection = 3
	if selection > 3:
		selection = 1
		
func printselect():
	print(selection)
	pass
	
func inputs():
	if Inputs.just_key_left:
		if canselect:
			$move.play()
			selection -= 1
			printselect()
	if Inputs.just_key_right:
		if canselect:
			selection += 1
			printselect()
			$move.play()
	if Inputs.just_key_down:
		if canselect:
			$move.play()
			selection -= 2
			printselect()
	if Inputs.just_key_up:
		if canselect:
			selection += 2
			printselect()
			$move.play()
	if Inputs.just_key_jump:
		if canselect:
			$select.play()
			if selection == 1:
				OS.window_fullscreen = !OS.window_fullscreen
				pass
			if selection == 2:
				if !volumenabled:
					volumenabled = true
					canselect = false
			if selection == 3:
				OS.vsync_enabled = !OS.vsync_enabled
				pass
				
				
				
