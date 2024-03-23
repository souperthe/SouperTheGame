extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var down = false
var combostarted = false




func _ready():
	$animator.play("reset")
# Called when the node enters the scene tree for the first time


func _process(_delta):
	$bar.max_value = global.combotimer.wait_time
	$bar.value = global.combotimer.get_time_left()
	$newcombotext.bbcode_text = (str("[center]", global.combo)) 
	$combotext.bbcode_text = (str("[center][shake rate=20.0 level=5 connected=1]", global.combo))
	if !global.combo == 0 and not down:
		$bar.visible = true
		$animator.play("start")
		down = true
	if global.combo == 0 and down:
		$bar.visible = false
		$animator.play("end")
		down = false
	#if !global.combo == 0:
		#$bar.value -= 0.3
		
func startcountdown():
	pass
	#combostarted = true
	#$bar.value = 100
	#$animato2.play("meter")
