extends Area2D

var player
var wentin = false
var done = false
export (String) var targetscene
var cangoin = false
export (bool) var onescape = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	cangoin = global.panic or !onescape
	$Red.rotation_degrees += 2
	if cangoin:
		$Red.modulate.a8 = 255
	if !cangoin:
		$Red.modulate.a8 = 100
	if wentin:
		var amount = 6
		if not done:
			player.cutscene()
			player.position = lerp(player.position, position, amount * delta)
			player.animator.scale.x = lerp(player.animator.scale.x, 0, amount * delta)
			player.animator.scale.y = lerp(player.animator.scale.y, 0, amount * delta)
			player.animator.play("hurt")
			#global.cutscene = true
			global.lockcamera = true
			#global.camerazoom = lerp(global.camerazoom, 0.6, amount * delta)
			global.fill.paused = true
		var t = Timer.new()
		t.set_wait_time(0.7)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		done = true
		#fadein()
		changescene()
	pass
	
func numberthing(amount):
	var dashtrail = preload("res://assets/objects/smallnumber.tscn")
	var ghost: Node2D = dashtrail.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x + 50
	ghost.position.y = self.position.y
	ghost.number = str(amount)

func _on_lapportal_body_entered(body):
	if body is Player:
		if cangoin:
			player = body
			wentin = true
			$AudioStreamPlayer2D.play()
			global.escaperoom = []
			global.addscore(1000)
			numberthing("+1000")
			cangoin = false
	pass # Replace with function body.
	
func fadein():
	var weiner = false
	var t = Timer.new()
	t.set_wait_time(0.7)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	if not weiner:
		ct._tin()
		weiner = true
		
func enterscene():
	ct._fout()
	global.room_goto(targetscene, "lapexit")


func changescene():
	ct._fin()
	var e = Timer.new()
	e.set_wait_time(0.3)
	e.set_one_shot(true)
	self.add_child(e)
	e.start()
	yield(e, "timeout")
	enterscene()
	#ayer.animator.scale = Vector2(player.defaultscale, player.defaultscale)
	player.exitlapportal()
	global.camerazoom = 1
	global.cutscene = false
	global.lockcamera = false
	if onescape:
		global.laps += 1
	global.fill.paused = false

