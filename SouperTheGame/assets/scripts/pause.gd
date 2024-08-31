extends CanvasLayer

var paused := false
var canpause := true

func _process(delta):
	if Input.is_action_just_pressed(plr.pausekey):
		if canpause:
			paused = !paused
			$pause.play()
			if paused:
				visible = true
				get_tree().paused = true
			else:
				visible = false
				get_tree().paused = false
