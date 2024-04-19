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
	$hitpart3.emitting = false
	if destoryed:
		destory()


func _process(delta):
	if global.oldtodmode:
		queue_free()
	#if overlaps_body(objplayer):
		#destory()
		
func deletetile():
	var position1 = position
	position1.y += 16
	var position2 = position
	position2.x += 16
	position2.y += 32
	var position3 = position
	position3.y += 32
	var position4 = position
	position4.x += 16
	position4.y += 16 
	global.delete_tile_at(position1)
	global.delete_tile_at(position2)
	global.delete_tile_at(position3)
	global.delete_tile_at(position4)
func destory():
	global.resetcombo()
	$CollisionShape2D.queue_free()
	global.camera.shake2(1, 0.2)
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
	
func kill(blahblah):
	destory()
	
	
func hitpart():
	$hitpart3.emitting = true
	
func deadsound():
	$hurt3.play()
