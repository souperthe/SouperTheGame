extends Control

var volume = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func active():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db($VSlider.step))
	if Input.is_action_pressed("move_up"):
		$VSlider.step += 0.04
		if $VSlider.step > 2:
			$VSlider.step = 2
		$Control/mover.rect_position.y += 5
		if $Control/mover.rect_position.y > 71:
			$Control/mover.rect_position.y = 71
	if Input.is_action_pressed("move_down"):
		$VSlider.step += -0.04
		if $VSlider.step < 0:
			$VSlider.step = 0
		$Control/mover.rect_position.y += -5
		if $Control/mover.rect_position.y < -149:
			$Control/mover.rect_position.y = -149

