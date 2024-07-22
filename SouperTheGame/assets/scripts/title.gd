extends Node2D

var going := false

func createtransition():
	var whiteflash = preload("res://assets/objects/circletransistion.tscn")
	var ghost: CanvasLayer = whiteflash.instantiate()
	global.add_child(ghost)
	ghost.targetroom = "res://assets/scenes/test.tscn"
	ghost.targetdoor = "1"
	#ghost.door = true
	

func _process(delta):
	if Input.is_action_just_pressed(plr.enterkey):
		going = true
		music_controller.stop()
		global.oneshot_sfx("res://assets/sounds/metalrandomized.tres", get_viewport_rect().size / 2, -5)
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		await t.timeout
		createtransition()
