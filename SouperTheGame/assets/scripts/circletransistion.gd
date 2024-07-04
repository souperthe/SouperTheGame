extends CanvasLayer

var targetroom = 0
var targetdoor = 0
var door = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("dothing")
	if door:
		$AudioStreamPlayer2D.play()
	pass # Replace with function body.


func gotoroom():
	global.gotoroom(targetroom, targetdoor)
	if door:
		plr.state = plr.states.normal
