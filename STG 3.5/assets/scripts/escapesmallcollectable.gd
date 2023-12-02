extends Area2D


var time = 0
var amplitude = 1.0

var frequency = 1.0
var cancollect = true

onready var default_pos = $AnimatedSprite.get_position()
onready var Logo = $AnimatedSprite
var active 


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("default")
	$AnimatedSprite.frame = 0
	if (global.escaperoom.has(global.targetRoom2 + name)):
		queue_free()
	$AnimatedSprite.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	time += _delta * frequency
	Logo.set_position(default_pos + Vector2(0, sin(time) * amplitude))
	$CollisionShape2D.disabled = !global.panic
	active = global.panic
	if not active:
		$AnimatedSprite.modulate.a8 = 128
	if active:
		$AnimatedSprite.modulate.a8 = 255
	if not cancollect:
		position = lerp(position, objplayer.position, 4 * _delta)


func _on_smallcollectable_body_entered(_body):
	global.resetcombo()
	global.addscore(10)
	queue_free()
	global.escapeplaysmall()



func _on_smallcollectable_area_entered(_area):
	global.resetcombo()
	global.addscore(10)
	global.collectablesroom.append(global.targetRoom2 + name)
	queue_free()
	global.escapeplaysmall()


func _on_escapesmallcollectable_area_entered(_area):
	if active:
		if cancollect:
			global.resetcombo()
			global.addscore(10)
			global.escaperoom.append(global.targetRoom2 + name)
			global.escapeplaysmall()
			cancollect = false
			var t = Timer.new()
			t.set_wait_time(0.2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			queue_free()
