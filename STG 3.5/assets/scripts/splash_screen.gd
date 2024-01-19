extends Control


func _ready():
	$Splashscreen.modulate.a8 = 0
	ct._tout()
	$Title.position.y = -150
	$Title.position.x = 480
	$Demo.position.y = 580
	$Demo.position.x = 480
	$RichTextLabel.visible = false
	$yay.stop()
	yield(get_tree().create_timer(1.0), "timeout")
	$anim.play("start1")
	yield(get_tree().create_timer(7.5), "timeout")
	ct._tout()
	global.room_goto("res://assets/scenes/newTitle.tscn", "door1")
