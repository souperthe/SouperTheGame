extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var destoryed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.othersroom.has(global.targetRoom2 + name)):
		queue_free()
	$sprite.visible = true
	$hitpart1.emitting = false
	$hitpart2.emitting = false
	$hitpart3.emitting = false
	$hitpart4.emitting = false
	if destoryed:
		destory()


#func _process(delta):
	#if overlaps_body(objplayer):
		#destory()
		

func destory():
	global.addcombo()
	$CollisionShape2D.queue_free()
	hitpart()
	deadsound()
	$sprite.visible = false
	global.othersroom.append(global.targetRoom2 + name)
	var t = Timer.new()
	t.set_wait_time(4)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	queue_free()
	
	
func hitpart():
	$hitpart1.emitting = true
	$hitpart2.emitting = true
	$hitpart3.emitting = true
	$hitpart4.emitting = true
	
func deadsound():
	$hurt3.play()
