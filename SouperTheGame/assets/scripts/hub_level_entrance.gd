extends Node2D

@export var spritename := "house"
@export var target_scene :String
@export var target_door :String
var entered := false

func _ready():
	z_index = 0
	var texture := str("res://assets/images/hublevels/", spritename, ".png")
	$sprite.texture = load(texture)
	$pressenter.play("default")

func createtransition():
	var whiteflash = preload("res://assets/objects/fadetransistion.tscn")
	var ghost: CanvasLayer = whiteflash.instantiate()
	var ghostanimator: AnimationPlayer = ghost.get_node("AnimationPlayer")
	ghostanimator.speed_scale = 1
	global.add_child(ghost)
	ghost.targetroom = target_scene
	ghost.targetdoor = target_door
	ghost.door = true

func _process(delta):
	if $Area2D.overlaps_body(plr):
		$pressenter.position.y = plr.position.y - position.y - 50
		$pressenter.position.x = plr.position.x - position.x
		
		$pressenter.visible = !entered
		if !entered:
			if Input.is_action_just_pressed(plr.enterkey):
				entered = true
				plr.state = plr.states.hubactor
				global.resetroom = target_scene
				global.resetdoor = target_door
				$AnimationPlayer.play("new_animation")
				music_controller.stop()
				z_index = 3
	else:
		#$pressenter.position.y = 0
		#$pressenter.position.x = 0
		$pressenter.visible = false


#func _on_area_2d_body_entered(body):
	#if body.name == plr.name:
		#print("yea")
	#pass # Replace with function body.


#func _on_area_2d_body_exited(body):
	#if body.name == plr.name:
		#print("no")
	#pass # Replace with function body.
