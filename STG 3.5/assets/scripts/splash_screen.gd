extends Control


func _ready():
	$Splashscreen.modulate.a8 = 0
	ct._tout()
	$Title.position.y = -150
	$Title.position.x = 480
	$Demo.position.y = 580
	$Demo.position.x = 480
	$yay.stop()
	yield(get_tree().create_timer(1.0), "timeout")
	$anim.play("start")
	yield(get_tree().create_timer(6.5), "timeout")
	ct._tout()
	get_tree().change_scene("res://assets/scenes/newTitle.tscn")
