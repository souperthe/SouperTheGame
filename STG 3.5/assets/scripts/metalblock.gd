extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var destoryed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.othersroom.has(global.targetRoom2 + name)):
		queue_free()
	#$sprite.visible = true
	#$hitpart1.emitting = false
	#$hitpart2.emitting = false
	#$hitpart3.emitting = false
	#$hitpart4.emitting = false
	if destoryed:
		destory()


func _process(_delta):
	if global.oldtodmode:
		queue_free()
		
		
func bangeffect():
	var whiteflash = preload("res://assets/objects/bangeffect.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x + 32
	ghost.position.y = self.position.y + 32
	
func destoryffect():
	var whiteflash = preload("res://assets/objects/MetalPartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y

	#if overlaps_body(objplayer):
		#destory()
		

func destory():
	global.addcombo()
	queue_free()
	#hitpart()
	deadsound()
	destoryffect()
	global.camera.shake2(6, 0.2)
	bangeffect()
	global.othersroom.append(global.targetRoom2 + name)
	global.playsound(Vector2(position.x + 32, position.y + 32), "res://assets/sound/destorymetalh.tres")
	#var t = Timer.new()
	#t.set_wait_time(4)
	#t.set_one_shot(true)
	#self.add_child(t)
	#t.start()
	#yield(t, "timeout")
	#queue_free()
	
	
func hitpart():
	$hitpart1.emitting = true
	$hitpart2.emitting = true
	$hitpart3.emitting = true
	$hitpart4.emitting = true
	
func deadsound():
	$hurt3.play()
