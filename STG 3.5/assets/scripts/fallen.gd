extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rang = RandomNumberGenerator.new()
var rand2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(_delta):
	var rand = rang.randi_range(2, 3)
	rand2 = rand
func dothing():
	#$Control/ouch.play()
	$AnimationPlayer.stop()
	$AnimationPlayer.play("dostuff")
	#global.camera.shake2(10, 0.5)
	$Control/ouch.position = objplayer.position
	if !global.panic:
		playlaugh()
		playfunny()
	#playcock()
	#$Control/static.play("static")
	$Control/static.frame = 0
	
	
func playlaugh():
	randomize()
	var t = Timer.new()
	t.set_wait_time(.9)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	if rand2 == 1:
		$Control/laugh.play()
	if rand2 == 2:
		$Control/laugh2.play()
	if rand2 == 3:
		$Control/laugh3.play()

func playfunny():
	var t = Timer.new()
	t.set_wait_time(.4)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$Control/badumtss.play()
func playcock():
	var whiteflash = preload("res://assets/objects/cocking.tscn")
	var ghost: AudioStreamPlayer2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = $Control/ouch.position
	ghost.play()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
