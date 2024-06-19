extends "res://assets/scripts/keyfunction.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func portalffect():
	var whiteflash = preload("res://assets/objects/enemyportal.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = $Position2D.position.x
	ghost.position.y = $Position2D.position.y - 15
	
func baddie():
	var whiteflash = preload("res://assets/objects/enemys/forkdevil.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = $Position2D.position.x
	ghost.position.y = $Position2D.position.y
	

# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.othersroom.has(global.targetRoom2 + name)):
		$collide12.queue_free()
		$collide11.position.y = -96
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func dothing():
	var t = Timer.new()
	t.set_wait_time(0.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$collide11.position.y = -96
	global.camera.shake2(5, 0.2)
	$collide11/slam.play()
	$collide12.queue_free()
	global.othersroom.append(global.targetRoom2 + name)
