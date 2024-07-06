extends Node2D
@export var target_scene :String
@export var target_door :String
var doored = false
var dooredtarget = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func createtransition():
	var whiteflash = preload("res://assets/objects/circletransistion.tscn")
	var ghost: CanvasLayer = whiteflash.instantiate()
	global.add_child(ghost)
	ghost.targetroom = target_scene
	ghost.targetdoor = target_door
	ghost.door = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Area2D.overlaps_body(plr):
		if plr.state == plr.states.normal:
			if SInput.just_key_up:
				plr.state = plr.states.actor
				plr.animator.play("door")
				plr.animator.speed_scale = 0.3
				plr.vsp = 0
				plr.hsp = 0
				plr.doorarrowcheck(false)
				dooredtarget = plr
				createtransition()
				doored = true
				#global.gotoroom(target_scene, target_door)
	if doored:
		#print("doored ", dooredtarget.name)
		dooredtarget.position.x = lerp(dooredtarget.position.x, position.x, 5 * delta)


func _on_area_2d_body_entered(body):
	if body.name == plr.name:
		body.doorarrowcheck(true)


func _on_area_2d_body_exited(body):
	if body.name == plr.name:
		body.doorarrowcheck(false)
