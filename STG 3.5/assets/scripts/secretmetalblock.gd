extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var destoryed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.othersroom.has(global.targetRoom2 + name)):
		queue_free()
		deletetile()
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
		
func deletetile():
	var position2 = position
	position2.x += 32
	var position3 = position
	position3.y += 32
	var position4 = position
	position4.x += 32
	position4.y += 32
	global.delete_tile_at(position)
	global.delete_tile_at(position2)
	global.delete_tile_at(position3)
	global.delete_tile_at(position4)
func destory():
	global.addcombo()
	$CollisionShape2D.queue_free()
	hitpart()
	deadsound()
	deletetile()
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
