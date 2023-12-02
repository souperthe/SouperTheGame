extends Node2D


var anchorY = 5
var frequency = 0.1
var amplitude = 20
var timer = 0
var player

onready var y = position.y
var collected = false
var dick = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.collectablesroom.has(global.targetRoom2 + name)):
		queue_free()


func _process(delta : float) -> void:
	if not collected:
		$sprite.position.y = anchorY + sin(timer*frequency)*amplitude
		timer += 0.5


func _on_treasure_body_entered(body):
	if body is Player:
		player = body
		if not dick:
			collect()
	pass # Replace with function body.
	
func collect():
	$AudioStreamPlayer2D.play()
	global.combotimer.paused = true
	dick = true
	collected = true
	player.velocity = Vector2(0,0)
	player.cutscene()
	player.animator.play("collect")
	position = player.position
	position.y += -60
	var t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	player.idle()
	global.addscore(650)
	global.combotimer.paused = false
	global.collectablesroom.append(global.targetRoom2 + name)
	global.treasure = true
	queue_free()
	
