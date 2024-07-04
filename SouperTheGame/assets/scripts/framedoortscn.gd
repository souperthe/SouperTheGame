extends Node2D
@export var target_scene :String
@export var target_door :String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Area2D.overlaps_body(plr):
		if plr.state == plr.states.normal:
			if SInput.just_key_up:
				global.targetdoor = target_door
				global.gotoroom(target_scene, target_door)
	pass
