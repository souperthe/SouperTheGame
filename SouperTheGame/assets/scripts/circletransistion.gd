extends CanvasLayer

var targetroom = 0
var targetdoor = 0
var hub := false
@export var door :bool
# Called when the node enters the scene tree for the first time.
func _ready():
	if !hub:
		$AnimationPlayer.play("dothing")
	if hub:
		$AnimationPlayer.play("dothing_hub")
	if door:
		$AudioStreamPlayer2D.play()
	pass # Replace with function body.


func gotoroom():
	if !hub:
		global.gotoroom(targetroom, targetdoor)
		if door:
			plr.state = plr.states.normal
	else:
		global.gotoroom(targetroom, targetdoor)
		plr.state = plr.states.hub
			
			
func dingdong():
	global.oneshot_sfx_global("res://assets/sounds/sfx/sfx_elevate.wav")
