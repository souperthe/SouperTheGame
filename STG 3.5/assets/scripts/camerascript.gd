extends Camera2D

onready var p1 = objplayer
onready var p2 = presobjs.player2

var zoomin = 1
var zoommax = 2
var counter = 0
var rotates = 0 
var rotatesamount = 5
var yoffset = 2
var smoothingspeed = global.cameraspeed
var shakeamount = 2
var limitleft
var limitright
var limittop
var limitbottom

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tet = false
onready var rand = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	limitleft = limit_left
	limitright = limit_left
	limittop = limit_top
	limitbottom = limit_bottom
	position.y = objplayer.position.y - yoffset
	position.x = objplayer.position.x
	#if roomhandle.currentscene.get_node(global.targetdoor):
		#position.x = roomhandle.currentscene.get_node(global.targetdoor).position.x
		#position.y = roomhandle.currentscene.get_node(global.targetdoor).position.y
	#if !roomhandle.currentscene.get_node(global.targetdoor):
		#position.x = 0
		#position.y = 0
	pass # Replace with function body.


func _process(_delta):
	#limit_bottom = 10000000
	#limit_right = 10000000
	#limit_left = -10000000
	#limit_top = -10000000
	global.camera = self
	var py = roomhandle.m * objplayer.position.y - yoffset
	var px = roomhandle.m * objplayer.position.x 
	rotatesamount = global.camerarotamount
	scale.x = roomhandle.m
	if $shake.time_left > 0:
		randomize()
		self.offset = Vector2(
				rand.randi_range(-shakeamount, shakeamount),
				rand.randi_range(-shakeamount, shakeamount)	
	)
	else:
		self.offset = Vector2(0,0)
	if global.panic:
		escapetilt()
		var idkanymore = cos(rotates)
		if global.panic:
			rotates += 2 * _delta
			rotation_degrees = (idkanymore * rotatesamount)
	if !global.panic:
		$AnimationPlayer.play("reset")
		$CanvasLayer/wavy.visible = false
		rotation_degrees = 0
	smoothingspeed = global.cameraspeed
	self.offset.x = lerp(self.offset.x, 0, 0.05)
	self.offset.y = lerp(self.offset.x, 0, 0.05)
	if not presobjs.player2:
		zoom.x = global.camerazoom
		zoom.y = global.camerazoom
		if !objplayer.currentstate == "bossdead":
			if !global.lockcamera:
				if global.camerasmoothing:
					position.x = px
					position.y = lerp(position.y, py, smoothingspeed)
				if !global.camerasmoothing:
					if objplayer.currentstate == "MachTurn":
						position.x = lerp(position.x, px, 0.5)
						position.y = py
					if !objplayer.currentstate == "MachTurn":
						position.x = px
						position.y = py
		else:
			if objplayer.animator.animation == "slipland":
				if !global.lockcamera:
					position.x = lerp(position.x, px, 0.01)
					position.y = lerp(position.y, py, 0.01)
	if presobjs.player2:
		var xz = objplayer.position.x-presobjs.player2.position.x
		var yz = objplayer.position.y-presobjs.player2.position.y
		position = (objplayer.position + presobjs.player2.position) / Vector2(2,2)
		zoom.x = max(zoomin, abs((xz - yz)))/800
		zoom.y = max(zoomin, abs((xz - yz)))/800
		#zoom.y = max(zoomin, abs((yz)))/800
		limit_bottom = 10000000
		limit_right = 10000000
		limit_left = -10000000
		limit_top = -10000000
		if zoom.x < zoomin:
			zoom.x = zoomin
			zoom.y = zoomin
			
			
func shake(amount):
	if global.shake_effects:
		randomize()
		self.offset = Vector2(
		rand.randi_range(-amount, amount),
		rand.randi_range(-amount, amount)	
		)
	
func shake2(amount, time):
	if global.shake_effects:
		randomize()
		$shake.wait_time = time
		$shake.start()
		shakeamount = amount
	#self.offset = Vector2(
		#rand.randi_range(-amount, amount),
		#rand.randi_range(-amount, amount)	
	#)
	
			
		
			
func escapetilt():
	$CanvasLayer/wavy.visible = true
	$AnimationPlayer.play("panic")
	
#	pass
