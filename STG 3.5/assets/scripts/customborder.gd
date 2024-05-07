extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var optionon = false
var draggingposition = Vector2()
var moving = false
var mousestart = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	#if global.camera:
		#$CanvasLayer/options/HBoxContainer/TextureRect.texture.viewport_path = global.camera
	var lerpamount = 0.3
	optionon = get_viewport().get_mouse_position().y < 40
	if OS.window_fullscreen:
		$CanvasLayer.visible = false
	if !OS.window_fullscreen:
		$CanvasLayer.visible = true
	$CanvasLayer/options/HBoxContainer/WindowName.text = global.windowtitle
	OS.set_window_title(str(global.windowtitle))
	if moving:
		var mouse_delta = Vector2(get_viewport().get_mouse_position())
		OS.window_position += mouse_delta - mousestart
	if optionon:
		$CanvasLayer/options.rect_position.y = lerp($CanvasLayer/options.rect_position.y, 0, lerpamount)
		$CanvasLayer/Line2D.modulate.a8 = lerp($CanvasLayer/Line2D.modulate.a8, 255, lerpamount)
	if !optionon:
		$CanvasLayer/options.rect_position.y = lerp($CanvasLayer/options.rect_position.y, -30, lerpamount)
		$CanvasLayer/Line2D.modulate.a8 = lerp($CanvasLayer/Line2D.modulate.a8, 0, lerpamount)
	pass




func _on_options2_mouse_entered():
	#optionon = true
	pass # Replace with function body.


func _on_options2_mouse_exited():
	#optionon = false
	#if not Rect2(Vector2(), rect_size).has_point(get_local_mouse_position()):
		#optionon = false
	pass # Replace with function body.


func _on_mousedetect_mouse_entered():
	#ptionon = true
	pass # Replace with function body.


func _on_mousedetect_mouse_exited():
	#ptionon = false
	pass # Replace with function body.


func _on_options_gui_input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		OS.alert("message", "title")
	pass # Replace with function body.


func _on_buttons_gui_input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		if !moving:
			mousestart = get_viewport().get_mouse_position()
		moving = event.is_pressed()
	pass # Replace with function body.


func _on_HBoxContainer_gui_input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		$AudioStreamPlayer.play()
	pass # Replace with function body.
