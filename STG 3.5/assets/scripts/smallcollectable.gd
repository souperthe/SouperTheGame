extends Area2D


var time = 0
var amplitude = 1.0

var frequency = 1.0
var cancollect = true

onready var default_pos = $AnimatedSprite.get_position()
onready var Logo = $AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("default")
	$AnimatedSprite.frame = 0
	if (global.collectablesroom.has(global.targetRoom2 + name)):
		queue_free()
	$AnimatedSprite.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	time += _delta * frequency
	Logo.set_position(default_pos + Vector2(0, sin(time) * amplitude))
	if not cancollect:
		position = lerp(position, objplayer.position, 4 * _delta)


func _on_smallcollectable_body_entered(_body):
	global.resetcombo()
	global.addscore(10)
	queue_free()
	global.playsmall()



func _on_smallcollectable_area_entered(_area):
	if cancollect:
		global.resetcombo()
		global.addscore(10)
		global.collectablesroom.append(global.targetRoom2 + name)
		global.playsmall()
		cancollect = false
		var t = Timer.new()
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		queue_free()
