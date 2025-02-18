extends Control

var glb := global
var player := plr
var enabled := false

func evaluate(command, variable_names = [], variable_values = []) -> void:
	var expression = Expression.new()
	var error = expression.parse(command, variable_names)
	if error != OK:
		#push_error(expression.get_error_text())
		#$bass.play()
		OS.alert(str(expression.get_error_text()), "ERROR")
		return
	else:
		$bass.play()

	var result = expression.execute(variable_values, self)
	#if not expression.has_execute_failed():
		#print(str(result))
func set_timescale(speed):
	Engine.time_scale = speed
	print("timescale set to: ", speed)
	
func reset():
	global.reset()

func mutegame():
	AudioServer.set_bus_mute(0, true)
func set_fps(fps):
	Engine.max_fps = fps
	print("fps set to: ", fps)
	
func bptm():
	plr.position = get_global_mouse_position()
	
func set_playerstate(state):
	plr.state = str(state)
	print("player state set to: ", str(state))
	
func alert(message, title):
	OS.alert(message, title)
	
func escape(trueorfalse):
	global.activateescape(trueorfalse)
	
func playsong(songname, yea = false):
	music_controller.play(str("res://assets/sounds/", songname), yea)
	
func stopmusic():
	music_controller.stop()
	
func gotoroom(roomname, door = 1):
	var room := str("res://assets/scenes/", roomname)
	global.gotoroom(room, str(door))
	
func funny():
	for i in range(8):
		var xvelo := randf_range(15,-15)
		var yvelo := randf_range(-5,-15)
		var sprite := str("res://assets/images/otheranimated/hurtpeices/hurtpeices_000", i + 1, ".png")
		global.createdeadthing(plr.position, sprite, xvelo, yvelo)
	
func roomgoto(roomname, door = 1):
	var room := str("res://assets/scenes/", roomname)
	global.gotoroom(room, str(door))
	
func scenegoto(roomname, door = 1):
	var room := str("res://assets/scenes/", roomname)
	global.gotoroom(room, str(door))
	
func screenshot():
	var img := get_viewport().get_texture().get_image()
	var tex := ImageTexture.create_from_image(img)
	$TextureRect.set_texture(tex)
	global.oneshot_sfx("res://assets/sounds/photorandomized.tres", camera.position, -5)
	$AnimationPlayer.stop()
	$AnimationPlayer.play('screenshot')

func spawnobj(obj, amount:int, presistent := false):
	var selectedobj := str("res://assets/objects/", obj)
	for i in range(amount):
		global.createobject(selectedobj, camera.position)
	
func disable_climits():
	camera.limit_bottom = 10000000
	camera.limit_top = -10000000
	camera.limit_right = 10000000
	camera.limit_left = -10000000
	
func set_cameralock(lock):
	camera.locked = lock

func _process(_delta):
	if Input.is_action_just_pressed("debug"):
		enabled = !enabled
		match(enabled):
			false:
				$yep.play("new_animation")
				$Control/TextEdit.focus_mode = false
			true:
				$yep.play("apear")
				$Control/TextEdit.focus_mode = true
	


func _on_text_edit_text_submitted(new_text):
	evaluate(new_text)
	#$Control/TextEdit.text = ""
	pass # Replace with function body.


func _on_text_edit_text_changed(_new_text):
	$type.play()
	pass # Replace with function body.
