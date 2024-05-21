extends Control


func _ready():
	ct._freset()
	ct._treset()
	$Splashscreen.modulate.a8 = 0
	$Title.position.y = -150
	$Title.position.x = 480
	$Demo.position.y = 580
	$Demo.position.x = 480
	$RichTextLabel.visible = false
	$yay.stop()
	$RichTextLabel2.visible = false
	$Sdelogo.visible = false
	yield(get_tree().create_timer(1.0), "timeout")
	$anim.play("startnewnew")
	
	
func gototitle():
	#ct._freset()
	#ct._treset()
	#ct._tout()
	#ct._fout()
	global.room_goto("res://assets/scenes/newTitle.tscn", "door1")
	ct._fout()
