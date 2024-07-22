extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if overlaps_body(plr):
		if plr.state == plr.states.normal || plr.state == plr.states.jump:
			if Input.is_action_just_pressed(plr.upkey):
				plr.state = plr.states.ladder
				plr.animator.play("door")
				plr.animator.speed_scale = 0.3
				plr.vsp = 0
				plr.hsp = 0
				plr.position.x = self.position.x + 16
				#global.gotoroom(target_scene, target_door)


func _on_body_entered(body):
	if body.name == plr.name:
		body.laddering = true
	pass # Replace with function body.


func _on_body_exited(body):
	if body.name == plr.name:
		body.laddering = false
	pass # Replace with function body.
