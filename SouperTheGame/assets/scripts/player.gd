extends CharacterBody2D
class_name Player

@onready var animator := $AnimatedSprite2D
var grounded := false
const states := {
	normal = "normal",
	jump = "jump",
	actor = "actor",
	freefallprep = "freefallprep",
	freefalling = "freefalling",
	freefallland = 'freefallland',
	ladder = "ladder",
	dropkick = "dropkick",
	bump = "bump",
	punch = "punch",
	dash1 = "dash1",
	dash2 = "dash2",
	dashturn = "dashturn",
	dashjump = "dashjump",
	grapple = "grapple",
	screw = "screw",
	screwbounce = "screwbounce",
	skid = "skid",
	carry = "carry",
	throw = "throw",
	carryjump = "carryjump",
	sideflip = "sideflip",
	slide = "slide",
	dive = "dive"
}
var state := states.normal
var walled := false
var wallspeed := 0.0
var wall := Vector2()
var hsp := 0.0
var vsp := 0.0
var grv := 0.6
var spriteangle := 0.0
var spriteh := 1
var lastfloor := Vector2()
var laddering := false
var animationdone := false
var dash1 := 60
var move := 0
var currentframe := 0
var movedirection := 0
var scoreapproached := 0 
var ctime := 0.0
var skidbuffer := 0.0
var holdingobj = null

## inputs
var jumpkey := "p_jump"
var attackkey := "p_attack"
var shootkey := "p_shoot"
var pausekey := "p_pause"
var enterkey := "p_enter"
var dashkey := "p_dash"
var upkey := "p_up"
var downkey := "p_down"
var leftkey := "p_left"
var rightkey := "p_right"

@onready var doorarrow := $arrow

func landdust() -> void:
	var whiteflash := preload("res://assets/objects/landdust.tscn")
	var ghost: Node2D = whiteflash.instantiate()
	roomhandler.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	
func stepdust() -> void:
	var whiteflash := preload("res://assets/objects/stepdust.tscn")
	var ghost: Node2D = whiteflash.instantiate()
	roomhandler.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.z_index = self.z_index - 1
	
func rundust() -> void:
	var whiteflash := preload("res://assets/objects/rundust.tscn")
	var ghost: Node2D = whiteflash.instantiate()
	roomhandler.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.scale.x = spriteh
	ghost.z_index = self.z_index - 1


func _ready() -> void:
	animator.play("idle")
	animator.speed_scale = 0.15
	floor_constant_speed = true
	floor_snap_length = 64
	$charge.play("default")
	$charge.visible = false
	
	
var thing := false
	
func _physics_process(delta) -> void:
	currentframe = animator.frame
	wall = get_wall_normal()
	grounded = is_on_floor()
	walled = $frontstuff/wallcheck.is_colliding() and is_on_wall()
	if grounded:
		ctime = 10
	if !grounded:
		ctime -= 30 * delta
	$standing.disabled = state == states.slide
	$crouch.disabled = !(state == states.slide)
	#createothertrail()
	match(state):
		states.normal:
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			hsp = move * 10
			#vsp = 0
			if move != 0:
				spriteh = move
				if animator.animation != "land":
					animator.play("move")
				if is_on_wall():
					animator.speed_scale = 0.2
				else:
					animator.speed_scale = 0.3
				if animator.animation == "land":
					if animationdone:
						animator.play("move")
			else:
				if animator.animation != "land":
					animator.play("idle")
					animator.speed_scale = 0.15
				if animator.animation == "land":
					if animationdone:
						animator.play("idle")
			if Input.is_action_pressed(dashkey):
				state = states.dash1
				animator.speed_scale = 0.2
				dash1 = 60
				$sounds/machstart.play()
			if Input.is_action_just_pressed(jumpkey):
				animator.play("jump")
				animator.speed_scale = 0.3
				state = states.jump
				thing = false
				$sounds/jump.play()
				vsp = -15
			if Input.is_action_just_pressed(attackkey):
				state = states.punch
				hsp = spriteh * 18
				$sounds/swang.play()
				var rng = randi_range(1,2)
				match(rng):
					1:
						animator.play("punch")
					2:
						animator.play("kick")
				animator.speed_scale = 0.35
			if !is_on_floor():
				state = states.jump
				vsp = 0
				animator.play("fall")
				animator.speed_scale = 0.2
		states.jump:
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			hsp = lerpf(hsp, move * 8, 12 * delta)
			vsp += grv
			if Input.is_action_just_pressed(jumpkey) and ctime > 0 and animator.animation == "fall":
				animator.play("jump")
				animator.speed_scale = 0.3
				state = states.jump
				thing = false
				$sounds/jump.play()
				vsp = -15
			if Input.is_action_just_pressed(attackkey):
				state = states.dropkick
				animator.play("dropkick")
				animator.speed_scale = 0.25
				$sounds/swing.play()
				vsp = -12
				hsp = movedirection * 15
				if move != 0:
					spriteh = move
			if !Input.is_action_pressed(jumpkey):
				if animator.animation == "jump":
					if vsp < 2:
						vsp += 2
					#print("thing ", vsp)
			if is_on_floor():
				#if vsp > 1:
					state = states.normal
					animator.play("land")
					animator.speed_scale = 0.4
					$sounds/step.play()
					landdust()
					vsp = 0
			if Input.is_action_pressed(downkey):
				state = states.freefallprep
				animator.play("freefallprep")
				animator.speed_scale = 0.4
				vsp = -12
				$sounds/freefallprep.play()
		states.ladder:
			if Input.is_action_pressed(upkey):
				vsp = -8
			if Input.is_action_pressed(downkey):
				vsp = 10
				if grounded:
					state = states.normal
			if !Input.is_action_pressed(downkey) and !Input.is_action_pressed(upkey):
				vsp = 0
			if !laddering:
				state = states.normal
				vsp = 0
			if Input.is_action_pressed(jumpkey):
				animator.play("jump")
				animator.speed_scale = 0.3
				state = states.jump
				thing = false
				$sounds/jump.play()
				vsp = -15
		states.dropkick:
			createothertrail()
			vsp += grv
			if is_on_wall():
				state = states.bump
				hsp = spriteh * -7
				$sounds/bump.play()
				$sounds/swing.stop()
				$sounds/flashbulb.play()
				vsp = -7
				global.createobject("res://assets/objects/bangeffect.tscn", position)
			#if Input.is_action_pressed(downkey):
				#state = states.freefallprep
				#animator.play("freefallprep")
				#animator.speed_scale = 0.4
				#vsp = -12
				#$freefallprep.play()
			if Input.is_action_just_pressed(downkey):
				state = states.dive
				vsp = abs(hsp)
				$sounds/swish.play()
				animator.play("dive")
				animator.speed_scale = 0.2
			if is_on_floor():
				state = states.dash2
				animator.play("land")
				animator.speed_scale = 0.4
				$sounds/step.play()
				landdust()
				vsp = 0
		states.bump:
			if animator.animation != "bump":
				animator.play("bump")
				animator.speed_scale = 0.3
			vsp += grv
			if is_on_floor():
				#if vsp > 1:
					state = states.normal
					animator.play("land")
					animator.speed_scale = 0.4
					$sounds/step.play()
					landdust()
					#vsp = 0
		states.punch:
			createothertrail()
			hsp = lerpf(hsp, 0, 1.5 * delta)
			vsp = 0
			if is_on_wall():
				hsp = -hsp
				$sounds/swing.stop()
				$sounds/flashbulb.play()
				global.createobject("res://assets/objects/bangeffect.tscn", position)
			if is_on_floor():
				if Input.is_action_pressed(jumpkey):
					state = states.dashjump
					animator.play("freefallland")
					animator.speed_scale = 0.15
					$sounds/jump.play()
					vsp = -12
			if animationdone:
				if abs(hsp) > 18:
					if Input.is_action_pressed(dashkey):
						state = states.dash2
					else:
						state = states.normal
				else:
					state = states.normal
			if Input.is_action_just_pressed(attackkey):
				if currentframe > 1:
					state = states.dropkick
					animator.play("dropkick")
					animator.speed_scale = 0.25
					$sounds/swing.play()
					vsp = -12
					hsp = movedirection * 15
					#if move != 0:
						#spriteh = move
		states.dash1:
			
			hsp = lerpf(hsp, 0, 3 * delta)
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			if move != 0:
				spriteh = move
			createmachtrail()
			animator.play("move")
			animator.speed_scale += 0.02
			dash1 -= 80 * delta
			if !is_on_floor():
				state = states.jump
				#$sounds/machstart.stop()
				animator.play("fall")
				animator.speed_scale = 0.2
			if !Input.is_action_pressed(dashkey):
				state = states.normal
				#$sounds/machstart.stop()
			if dash1 < 1:
				state = states.dash2
				#$sounds/machstart.stop()
				$sounds/dash.play()
				hsp = spriteh * 30
		states.dash2:
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			createmachtrail()
			animator.play("mach3")
			animator.speed_scale = 0.3
			if is_on_floor():
				vsp = 0
				hsp = lerpf(hsp, spriteh * 20, 5 * delta)
				if Input.is_action_pressed(downkey):
					state = states.slide
					animator.play("slide")
					animator.speed_scale = 0.2
					#$sounds/justslid.play()
				if Input.is_action_pressed(dashkey):
					skidbuffer = 6
				if !Input.is_action_pressed(dashkey):
					skidbuffer -= 28 * delta
					if skidbuffer < 0:
						state = states.skid
						animator.play("skid")
						animator.speed_scale = 0.2
						$sounds/skid.play()
				if move == -spriteh:
					state = states.dashturn
					animator.play("dashskid1")
					animator.speed_scale = 0.2
					$sounds/machcancle.play()
			if Input.is_action_just_pressed(jumpkey) and ctime > 0:
				state = states.dashjump
				animator.play("freefallland")
				animator.speed_scale = 0.15
				$sounds/jump.play()
				vsp = -14
			if not is_on_floor():
				vsp += grv
			if Input.is_action_just_pressed(attackkey):
				state = states.punch
				#hsp = spriteh * 18
				$sounds/swang.play()
				var rng = randi_range(1,2)
				match(rng):
					1:
						animator.play("punch")
					2:
						animator.play("kick")
				animator.speed_scale = 0.35
			if walled:
				state = states.bump
				hsp = spriteh * -7
				$sounds/bump.play()
				$sounds/swing.stop()
				$sounds/flashbulb.play()
				vsp = -7
				global.createobject("res://assets/objects/bangeffect.tscn", position)
		states.freefallprep:
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			hsp = lerpf(hsp, move * 8, 10 * delta)
			vsp += grv
			if animationdone:
				state = states.freefalling
				$sounds/descend.play()
				vsp = 25
			if is_on_floor():
				state = states.freefallland
				$sounds/descend.stop()
				$sounds/flashbulb.play()
				$sounds/freefallland.play()
				$sounds/step.play()
				$sounds/freefallprep.stop()
				animator.play("freefallland")
				animator.speed_scale = 0.15
				camera.camerashake(15, 1)
				global.createobject("res://assets/objects/pounddust.tscn", position, spriteangle)
		states.freefalling:
			createothertrail()
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			hsp = lerpf(hsp, move * 8, 10 * delta)
			vsp += grv
			if is_on_floor():
				global.createobject("res://assets/objects/pounddust.tscn", position)
				state = states.freefallland
				$sounds/descend.stop()
				$sounds/flashbulb.play()
				$sounds/freefallland.play()
				$sounds/step.play()
				animator.play("freefallland")
				animator.speed_scale = 0.15
				camera.camerashake(15, 1)
			if Input.is_action_just_pressed(attackkey):
				state = states.dropkick
				animator.play("dropkick")
				animator.speed_scale = 0.25
				$sounds/swing.play()
				$sounds/descend.stop()
				vsp = -12
				hsp = movedirection * 15
				if move != 0:
					spriteh = move
		states.freefallland:
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			hsp = 0
			vsp = 0
			if animationdone:
				state = states.normal
				$sounds/pop.play()
		states.dashturn:
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			hsp = global.approach(hsp, 0, 35 * delta)
			if !grounded:
				vsp += grv
			if grounded:
				if abs(hsp) == 0:
					if move == -spriteh:
						state = states.dash2
						spriteh = -spriteh
						hsp = spriteh * 20
					else:
						state = states.normal
						spriteh = -spriteh
		states.dashjump:
			createmachtrail()
			vsp += grv
			if !Input.is_action_pressed(jumpkey):
				if vsp < 2:
					vsp += 2
			if is_on_floor():
				state = states.dash2
				hsp = spriteh * 20
				landdust()
			if is_on_wall():
				wallspeed = -abs(hsp) / 8
				$sounds/flashbulb.play()
				state = states.grapple
				animator.play("door")
				animator.frame = 4
				#print("grabbed wall at: ", position)
				#hsp = 0
			if Input.is_action_just_pressed(attackkey):
				state = states.dropkick
				animator.play("dropkick")
				animator.speed_scale = 0.25
				$sounds/swing.play()
				vsp = -12
				hsp = spriteh * 15
				#if move != 0:
					#spriteh = move
			if Input.is_action_pressed(downkey):
				state = states.screw
				animator.play("screwing")
				animator.speed_scale = 0.2
				vsp = 12
				$sounds/swing.stop()
				$sounds/swish.play()
		states.grapple:
			vsp = wallspeed
			wallspeed += grv / 4
			if Input.is_action_just_pressed(jumpkey):
				animator.play("jump")
				animator.frame = 0
				$sounds/jump.play()
				animator.speed_scale = 0.3
				state = states.dashjump
				spriteh = -spriteh
				vsp = -15
				hsp = spriteh * 17
			if !is_on_wall():
				state = states.jump
				animator.play("fall")
				animator.speed_scale = 0.2
				hsp = 0
			if Input.is_action_just_pressed(downkey):
				$sounds/pop.play()
				spriteh = -spriteh
				state = states.jump
				animator.play("fall")
				animator.speed_scale = 0.2
			if is_on_floor():
				state = states.normal
		states.screw:
			createothertrail()
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			hsp = lerpf(hsp, move * 8, 30 * delta)
			vsp += grv * 4
			if Input.is_action_just_pressed(attackkey):
				state = states.dropkick
				animator.play("dropkick")
				animator.speed_scale = 0.25
				$sounds/swing.play()
				vsp = -12
				hsp = movedirection * 15
				if move != 0:
					spriteh = move
			if is_on_floor():
				landdust()
				$sounds/flashbulb.play()
				$sounds/boing.play()
				state = states.screwbounce
				vsp = -8
				animator.play("jump")
				animator.speed_scale = 0.5
		states.screwbounce:
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			hsp = lerpf(hsp, move * 8, 5 * delta)
			if Input.is_action_just_pressed(attackkey):
				state = states.dropkick
				animator.play("dropkick")
				animator.speed_scale = 0.25
				$sounds/swing.play()
				vsp = -12
				hsp = movedirection * 15
				if move != 0:
					spriteh = move
			vsp += grv
			if is_on_floor():
				if Input.is_action_pressed(dashkey):
					landdust()
					if move != 0:
						spriteh = move
					state = states.dash2
					hsp = spriteh * 20
				else:
					landdust()
					if move != 0:
						spriteh = move
					state = states.normal
					animator.play("land")
					animator.speed_scale = 0.4
					$sounds/step.play()
					landdust()
		states.skid:
			#createothertrail()
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			hsp = global.approach(hsp, 0, 35 * delta)
			if !grounded:
				vsp += grv
			if grounded:
				if abs(hsp) == 0:
					state = states.normal
					$sounds/skid.stop()
					#spriteh = -spriteh
			if !grounded:
				state = states.jump
				animator.play("fall")
				$sounds/skid.stop()
		states.carry:
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			hsp = move * 6
			vsp = 0
			if is_instance_valid(holdingobj):
				holdingobj.position.x = position.x
				holdingobj.position.y = position.y - 50
			if move != 0:
				spriteh = move
				if animator.animation != "land":
					animator.play("move")
				if is_on_wall():
					animator.speed_scale = 0.3
				else:
					animator.speed_scale = 0.2
				if animator.animation == "land":
					if animationdone:
						animator.play("move")
			else:
				if animator.animation != "land":
					animator.play("carry")
					animator.speed_scale = 0.18
				if animator.animation == "land":
					if animationdone:
						animator.play("carry")
			if Input.is_action_just_pressed(attackkey):
				animator.frame = 0
				animator.play("punch")
				animator.speed_scale = 0.35
				state = states.throw
				#hsp = spriteh * 18
				if is_instance_valid(holdingobj):
					holdingobj.state = holdingobj.states.thrown
					holdingobj.hsp = spriteh * 18
					holdingobj.vsp = -5
					holdingobj.position.y = position.y - 12
				$sounds/deepswang.play()
				holdingobj = null
			if Input.is_action_pressed(downkey):
				#holdingobj.hsp = spriteh * 5
				holdingobj.state = holdingobj.states.normal
				holdingobj.position.y = position.y + 12
				$sounds/flashbulb.play()
				holdingobj = null
				state = states.normal
			if Input.is_action_pressed(jumpkey):
				animator.play("jump")
				animator.speed_scale = 0.3
				state = states.carryjump
				thing = false
				$sounds/jump.play()
				vsp = -10
			if !is_on_floor():
				state = states.carryjump
				animator.play("fall")
				animator.speed_scale = 0.2
			#if !is_instance_valid(holdingobj):
				#state = states.normal
		states.carryjump:
			move = -int(Input.is_action_pressed(leftkey)) - -int(Input.is_action_pressed(rightkey))
			hsp = lerpf(hsp, move * 6, 12 * delta)
			vsp += grv
			if is_instance_valid(holdingobj):
				holdingobj.position.x = position.x
				holdingobj.position.y = position.y - 50
			if Input.is_action_just_pressed(attackkey):
				vsp = -5
				#hsp = spriteh * 18
				if is_instance_valid(holdingobj):
					holdingobj.state = holdingobj.states.thrown
					holdingobj.hsp = spriteh * 18
					holdingobj.vsp = -5
					holdingobj.position.y = position.y - 12
				$sounds/deepswang.play()
				animator.frame = 0
				animator.play("punch")
				animator.speed_scale = 0.35
				state = states.throw
				holdingobj = null
			if Input.is_action_just_pressed(jumpkey) and ctime > 0 and animator.animation == "fall":
				animator.play("jump")
				animator.speed_scale = 0.3
				state = states.carryjump
				thing = false
				$sounds/jump.play()
				vsp = -15
			if !Input.is_action_pressed(jumpkey):
				if animator.animation == "jump":
					if vsp < 2:
						vsp += 2
					#print("thing ", vsp)
			if is_on_floor():
				#if vsp > 1:
					state = states.carry
					animator.play("land")
					animator.speed_scale = 0.4
					$sounds/step.play()
					landdust()
					vsp = 0
			#if !is_instance_valid(holdingobj):
				#state = states.jump
				#animator.play("fall")
				#animator.speed_scale = 0.2
		states.throw:
			hsp = global.approach(hsp, 0, 35 * delta)
			vsp += grv
			if animationdone:
				state = states.normal
		states.slide:
			createothertrail()
			hsp = global.approach(hsp, 0, 2 * delta)
			if !Input.is_action_pressed(downkey) and !$checkceil.is_colliding():
				state = states.dash2
			if abs(hsp) == 0:
				state = states.normal
				$sounds/justslid.stop()
			if !grounded:
				state = states.dive
				vsp = abs(hsp)
				$sounds/swish.play()
				animator.play("dive")
				animator.speed_scale = 0.2
			if walled:
				state = states.bump
				hsp = spriteh * -7
				$sounds/bump.play()
				$sounds/swing.stop()
				$sounds/flashbulb.play()
				vsp = -7
				global.createobject("res://assets/objects/bangeffect.tscn", position)
		states.dive:
			createothertrail()
			if walled:
				state = states.bump
				hsp = spriteh * -7
				$sounds/bump.play()
				$sounds/swing.stop()
				$sounds/flashbulb.play()
				vsp = -7
				global.createobject("res://assets/objects/bangeffect.tscn", position)
			if Input.is_action_pressed(jumpkey):
				state = states.freefallprep
				animator.play("freefallprep")
				animator.speed_scale = 0.4
				vsp = -12
				$sounds/freefallprep.play()
			if grounded:
				state = states.slide
				animator.play("slide")
				animator.speed_scale = 0.2
				landdust()
	if spriteh == 1:
		animator.flip_h = false
	if spriteh == -1:
		animator.flip_h = true
	$frontstuff.scale.x = spriteh
	if move != 0:
		movedirection = move
	else:
		movedirection = spriteh
	#if is_on_floor():
		#vsp = 0
	if is_on_ceiling():
		vsp = 1
	velocity.x = (hsp * 4000) * delta
	velocity.y = (vsp * 4000) * delta
	if is_on_floor():
		lastfloor = position
		var floornormal = get_floor_normal()
		#spriteangle = abs(rad_to_deg(get_floor_angle()))
		spriteangle = rad_to_deg(floornormal.angle() + deg_to_rad(90))
	else:
		spriteangle = 0
	statesound()
	animator.rotation_degrees = lerpf(animator.rotation_degrees, spriteangle, 15 * delta)
	$CanvasLayer/Control/Label.text = str("(", int(hsp), ", ", int(vsp), ")", ", ", state, ", ", animator.animation)
	scoreapproached = global.approach(scoreapproached, global.score, 200 * delta)
	$CanvasLayer/score/RichTextLabel.text = str("[center]", int(scoreapproached))
	move_and_slide()
	$charge.flip_h = animator.flip_h
	$charge.rotation_degrees = animator.rotation_degrees
	$CanvasLayer.visible = roomhandler.room_name != "title"
	if global.rank < 6:
		$CanvasLayer/Control2/rankometer.animation = "default"
		$CanvasLayer/Control2/rankometer.speed_scale = 0
		$CanvasLayer/Control2/rankometer.frame = global.rank
	if global.rank == 6:
		$CanvasLayer/Control/Control/rankometer.play("full")
		$CanvasLayer/Control/Control/rankometer.speed_scale = 1
	

func statesound() -> void:
	if state == states.dash2:
		if !$sounds/dash2.playing:
			$sounds/dash2.play()
			$charge.visible = true
	else:
		if $sounds/dash2.playing:
			$sounds/dash2.stop()
			$charge.visible = false
	if !state == states.dash1:
		if $sounds/machstart.playing:
			$sounds/machstart.stop()
	if state == states.slide:
		if !$sounds/slide.playing:
			$sounds/slide.play()
	else:
		if $sounds/slide.playing:
			$sounds/slide.stop()
	
func _on_animated_sprite_2d_frame_changed() -> void:
	match(state):
		states.normal:
			if animator.animation == "move":
				if animator.frame == 2 or animator.frame == 8:
					$sounds/step.play()
					stepdust()
		states.dash2:
			if animator.animation == "mach3":
				if animator.frame == 2:
					if is_on_floor():
						rundust()
		states.dashturn:
			if grounded:
				stepdust()
		states.skid:
			if grounded:
				stepdust()
		states.carry:
			if animator.animation == "move":
				if animator.frame == 2 or animator.frame == 8:
					$sounds/step.play()
					stepdust()
		states.slide:
			if grounded:
				stepdust()
	pass # Replace with function body.
	
func doorarrowcheck(what) -> void:
	$arrow.visible = what


func _on_animated_sprite_2d_animation_finished() -> void:
	animationdone = true
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_changed() -> void:
	animationdone = false
	pass # Replace with function body.

func createothertrail() -> void:
	if !$othertrailtimer1.time_left > 0:
		$othertrailtimer1.start()
		
func createmachtrail() -> void:
	if !$machtrail.time_left > 0:
		$machtrail.start()

func _on_othertrailtimer_1_timeout() -> void:
	global.createtrail(self.position, animator, Color8(255,255,255,255), 2)
	pass # Replace with function body.


func _on_machtrail_timeout() -> void:
	global.createmachtrail(self.position, animator, Color8(255,0,0,255), 1.5, self)
	pass # Replace with function body.


func _on_frontdetect_body_entered(body):
	if body is MetalBlock:
		if state == states.dash2 || state == states.dashjump:
			body.destroy()
	if body is Grabbable:
		if state == states.punch:
			state = states.carry
			holdingobj = body
			$sounds/swing.stop()
			$sounds/swang.stop()
			$sounds/swish.stop()
			$sounds/kerplunk.play()
			holdingobj.state = 1
		if state == states.dash2:
			body.destroy()
	if body is Baddie:
		if state == states.slide:
			if body.state != 2:
				body.state = 2
				body.hsp = hsp
				body.yeah()
				body.vsp = -17
		if state == states.dash2 || state == states.dashjump || state == states.dropkick || state == states.punch:
			var afsjkbasdjkbasdasdasdasd := velocity.normalized()
			position.x += afsjkbasdjkbasdasdasdasd.x * -32
			body.destroy(hsp, position)
			$sounds/swing.stop()
			$sounds/swang.stop()
			$sounds/swish.stop()
	pass # Replace with function body.


func _on_middledowndetect_body_entered(body):
	if body is Baddie:
		if state == states.screw || state == states.freefalling:
			body.destroy(0, position)
	if body is Grabbable:
		if state == states.freefalling:
			body.destroy()
	pass # Replace with function body.
