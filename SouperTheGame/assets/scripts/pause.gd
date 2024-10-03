extends CanvasLayer

var paused := false
var canpause := true

func _ready():
	visible = true

func _process(delta):
	$Control.modulate.a8 = global.approach($Control.modulate.a8, int(paused) *  255, 3000 * delta)
	match(paused):
		true:
			music_controller.mva = 5
			if Input.is_action_just_pressed(plr.enterkey):
				music_controller.currentsong = ""
				music_controller.stop()
				global.reset()
				paused = false
				get_tree().paused = false
		false:
			music_controller.mva = 1.5
	#print(int(paused))
	if Input.is_action_just_pressed(plr.pausekey):
		if canpause:
			paused = !paused
			$pause.play()
			if paused:
				#visible = true
				get_tree().paused = true
			else:
				#visible = false
				get_tree().paused = false
