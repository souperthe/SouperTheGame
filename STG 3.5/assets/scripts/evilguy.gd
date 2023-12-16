extends KinematicBody2D


onready var alpha = $Funnyboulder.modulate.a8
var maxspeed = 8 / 10
var mvsp = (maxspeed + (abs(objplayer.velocity.x) / 8))
var velocity := Vector2.ZERO
var speed = 70150
var pause = false
#var dir = Vector2.angle_to_point(position.x, position.y, (objplayer.position.x + objplayer.velocity.x), (objplayer.position.y + objplayer.velocity.y))


func _ready():
	#$ass.play()
	global.connect("reset", self, "destory")
	global.connect("scenechanged", self, "gotodoor")
	gotodoor()
	pass
	
	
func gotodoor():
	pause = false
	$Funnyboulder.modulate.a8 = 0
	position.x = -4050
	position.y = -4050
	yield(get_tree().create_timer(0.008), "timeout")
	#position = objplayer.position
	if roomhandle.currentscene.get_node("escapephone"):
		pause = true
	if roomhandle.currentscene.get_node("treasure"):
		pause = true
	if roomhandle.currentscene.get_node(global.targetdoor) and not pause:
		position.x = roomhandle.currentscene.get_node(global.targetdoor).position.x
		position.y = roomhandle.currentscene.get_node(global.targetdoor).position.y
		
func destory():
	queue_free()
	
	

	
	
func _physics_process(delta):
	if global.escapeexited == true:
		kill()
	velocity = move_and_slide(velocity, Vector2.UP)
	trail()
	if global.hardmode and global.panicdone:
		speed += 30
	if $Funnyboulder.modulate.a8 > 251 and !global.cutscene and !objplayer.currentstate == ("EnterDoor") and !objplayer.currentstate == ("ExitDoor") and !objplayer.currentstate == ("bossdead") and !pause:
		#position = lerp(position, objplayer.position, 3 * delta)
		#position = Vector2.slide(objplayer.position)
		#velocity = move_and_slide(velocity)
		var mousepoint = objplayer.get_position()
		var vector = (mousepoint - self.get_position()).normalized()
		var goto = (vector * speed * delta)
		velocity = lerp(velocity, goto, 1 * delta)
	else:
		velocity.x = lerp(velocity.x, 0, 5 * delta)
		velocity.y = lerp(velocity.y, 0, 5 * delta)
	if $Funnyboulder.modulate.a8 < 255:
		$Funnyboulder.modulate.a8 += 3
	
func _on_evilguy_body_entered(body):
	if body is Player:
		if $Funnyboulder.modulate.a8 == 255:
			velocity = Vector2(0,0)
			#body.hurtplayer()
			kill()
			body.changestate("bossdead")
			$Funnyboulder.modulate.a8 = 0
	pass # Replace with function body.
	
	
	
func trail():
	var dashtrail = preload("res://assets/objects/playerdashtrail.tscn")
	var ghost: AnimatedSprite = dashtrail.instance()
	var animator = $Funnyboulder
	get_parent().add_child(ghost)
	ghost.playing = false
	ghost.flip_h = animator.flip_h
	ghost.global_position = global_position
	ghost.scale.x = animator.scale.x
	ghost.scale.y = animator.scale.y
	ghost.z_index = animator.z_index - 1
	#ghost.position.y += -4.301
	ghost.frames = animator.frames
	ghost.animation = animator.animation
	ghost.frame = animator.frame
	ghost.rotation = animator.rotation
	ghost.modulate.r8 = 200
	ghost.modulate.g8 = 128
	ghost.modulate.b8 = 72


func _on_detect_body_entered(body):
	if body is Player:
		if $Funnyboulder.modulate.a8 == 255:
			#body.hurtplayer()
			body.changestate("bossdead")
			global.cutscene = true
			global.makeflash()
			#kill()
			$Funnyboulder.modulate.a8 = 0
	pass # Replace with function body.

func kill():
	createdead1(0, 0)
	queue_free()
	
func createdead1(velocityx, rotatespeed):
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	get_tree().get_current_scene().add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.velocity.y = -900
	ghost.velocity.x = velocityx
	ghost.spinamount = rotatespeed
	ghost.sprite.texture = load("res://assets/sprites/funnyboulder.png")
	ghost.sprite.scale.x = 0.6
	ghost.sprite.scale.y = 0.6
	
	
func goofysound():
	var whiteflash = preload("res://assets/objects/sillysfx3d.tscn")
	var ghost: Node2D = whiteflash.instance()
	get_tree().get_current_scene().add_child(ghost)
	ghost.playsound = true
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	
	


func _on_attackdetect_body_entered(body):
	if $Funnyboulder.modulate.a8 == 255:
		createdead1(body.velocity.x, body.velocity.x / 170)
		goofysound()
		global.addcombo()
		$Funnyboulder.modulate.a8 = 0
	pass # Replace with function body.
