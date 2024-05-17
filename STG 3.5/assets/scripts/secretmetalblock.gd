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
	$hitpart5.emitting = false
	if destoryed:
		destory()


func _process(_delta):
	if global.oldtodmode:
		deletetile()
		queue_free()
	#if is_instance_valid($sprite):
	$sprite.visible = global.showcolloisions
		
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
	hitpart()
	deadsound()
	deletetile()
	$sprite.modulate.a8 = 0
	global.othersroom.append(global.targetRoom2 + name)
	var t = Timer.new()
	t.set_wait_time(4)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	queue_free()

func kill(_blahblah):
	destory()
	
	
func hitpart():
	$hitpart5.emitting = true
	
func deadsound():
	$hurt4.play()
