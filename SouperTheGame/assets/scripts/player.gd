extends CharacterBody2D
class_name Player

@onready var animator := $AnimatedSprite2D
var grounded := false
enum states {
	normal,
	jump,
	actor,
	freefallprep,
	freefalling,
	freefallland,
	ladder,
	dropkick,
	bump,
	punch,
	dash1,
	dash2,
	dashturn,
	dashjump,
	grapple,
	screw,
	screwbounce
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
var move := 0
var movedirection := 0
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
	
var thing := false
	
func _physics_process(delta) -> void:
	wall = get_wall_normal()
	grounded = is_on_floor()
	walled = $frontstuff/wallcheck.is_colliding() and is_on_wall()
	#createothertrail()
	match(state):
		states.normal:
			move = -int(SInput.key_left) - -int(SInput.key_right)
			hsp = move * 10
			vsp = 0
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
			if SInput.just_key_jump:
				animator.play("jump")
				animator.speed_scale = 0.3
				state = states.jump
				thing = false
				$jump.play()
				vsp = -15
			if SInput.just_key_attack:
				state = states.punch
				hsp = spriteh * 18
				$swang.play()
				var rng = randi_range(1,2)
				match(rng):
					1:
						animator.play("punch")
					2:
						animator.play("kick")
				animator.speed_scale = 0.35
			if !is_on_floor():
				state = states.jump
				animator.play("fall")
				animator.speed_scale = 0.2
		states.jump:
			move = -int(SInput.key_left) - -int(SInput.key_right)
			hsp = lerpf(hsp, move * 8, 12 * delta)
			vsp += grv
			if SInput.just_key_attack:
				state = states.dropkick
				animator.play("dropkick")
				animator.speed_scale = 0.25
				$swing.play()
				vsp = -12
				hsp = movedirection * 15
				if move != 0:
					spriteh = move
			if !SInput.key_jump:
				if animator.animation == "jump":
					if vsp < 2:
						vsp += 2
					#print("thing ", vsp)
			if is_on_floor():
				#if vsp > 1:
					state = states.normal
					animator.play("land")
					animator.speed_scale = 0.4
					$step.play()
					landdust()
					vsp = 0
			if SInput.just_key_down:
				state = states.freefallprep
				animator.play("freefallprep")
				animator.speed_scale = 0.4
				vsp = -12
				$freefallprep.play()
		states.ladder:
			if SInput.key_up:
				vsp = -8
			if SInput.key_down:
				vsp = 10
				if grounded:
					state = states.normal
			if !SInput.key_down and !SInput.key_up:
				vsp = 0
			if !laddering:
				state = states.normal
				vsp = 0
			if SInput.just_key_jump:
				animator.play("jump")
				animator.speed_scale = 0.3
				state = states.jump
				thing = false
				$jump.play()
				vsp = -15
		states.dropkick:
			createothertrail()
			vsp += grv
			if is_on_wall():
				state = states.bump
				hsp = spriteh * -7
				$bump.play()
				$swing.stop()
				$flashbulb.play()
				vsp = -7
				global.createobject("res://assets/objects/bangeffect.tscn", position)
			#if SInput.just_key_down:
				#state = states.freefallprep
				#animator.play("freefallprep")
				#animator.speed_scale = 0.4
				#vsp = -12
				#$freefallprep.play()
			if is_on_floor():
				if SInput.key_dash:
					state = states.dash2
					animator.play("land")
					animator.speed_scale = 0.4
					$step.play()
					landdust()
				else:
					state = states.normal
					animator.play("land")
					animator.speed_scale = 0.4
					$step.play()
					landdust()
					#vsp = 0
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
					$step.play()
					landdust()
					#vsp = 0
		states.punch:
			createothertrail()
			hsp = lerpf(hsp, 0, 1.5 * delta)
			vsp = 0
			if is_on_wall():
				hsp = -hsp
				$swing.stop()
				$flashbulb.play()
				global.createobject("res://assets/objects/bangeffect.tscn", position)
			if is_on_floor():
				if SInput.just_key_jump:
					state = states.dashjump
					animator.play("freefallland")
					animator.speed_scale = 0.15
					$jump.play()
					vsp = -12
			if animationdone:
				if abs(hsp) > 18:
					if SInput.key_dash:
						state = states.dash2
					else:
						state = states.normal
				else:
					state = states.normal
			if SInput.just_key_attack:
				state = states.dropkick
				animator.play("dropkick")
				animator.speed_scale = 0.25
				$swing.play()
				vsp = -12
				hsp = movedirection * 15
				if move != 0:
					spriteh = move
		states.dash2:
			move = -int(SInput.key_left) - -int(SInput.key_right)
			createmachtrail()
			animator.play("mach3")
			animator.speed_scale = 0.3
			if is_on_floor():
				vsp = 0
				hsp = spriteh * 20
				if move == -spriteh:
					state = states.dashturn
					$machcancle.play()
				if SInput.just_key_jump:
					state = states.dashjump
					animator.play("freefallland")
					animator.speed_scale = 0.15
					$jump.play()
					vsp = -12
			if not is_on_floor():
				vsp += grv
			if SInput.just_key_attack:
				state = states.punch
				#hsp = spriteh * 18
				$swang.play()
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
				$bump.play()
				$swing.stop()
				$flashbulb.play()
				vsp = -7
				global.createobject("res://assets/objects/bangeffect.tscn", position)
		states.freefallprep:
			move = -int(SInput.key_left) - -int(SInput.key_right)
			hsp = lerpf(hsp, move * 8, 10 * delta)
			vsp += grv
			if animationdone:
				state = states.freefalling
				$descend.play()
				vsp = 25
			if is_on_floor():
				state = states.freefallland
				$descend.stop()
				$flashbulb.play()
				$freefallland.play()
				$step.play()
				$freefallprep.stop()
				animator.play("freefallland")
				animator.speed_scale = 0.15
				camera.camerashake(15, 1)
				global.createobject("res://assets/objects/pounddust.tscn", position, spriteangle)
		states.freefalling:
			createothertrail()
			move = -int(SInput.key_left) - -int(SInput.key_right)
			hsp = lerpf(hsp, move * 8, 10 * delta)
			vsp += grv
			if is_on_floor():
				global.createobject("res://assets/objects/pounddust.tscn", position)
				state = states.freefallland
				$descend.stop()
				$flashbulb.play()
				$freefallland.play()
				$step.play()
				animator.play("freefallland")
				animator.speed_scale = 0.15
				camera.camerashake(15, 1)
			if SInput.just_key_attack:
				state = states.dropkick
				animator.play("dropkick")
				animator.speed_scale = 0.25
				$swing.play()
				$descend.stop()
				vsp = -12
				hsp = movedirection * 15
				if move != 0:
					spriteh = move
		states.freefallland:
			move = -int(SInput.key_left) - -int(SInput.key_right)
			hsp = 0
			vsp = 0
			if animationdone:
				state = states.normal
				$pop.play()
		states.dashturn:
			move = -int(SInput.key_left) - -int(SInput.key_right)
			hsp = global.approach(hsp, 0, 35 * delta)
			if !grounded:
				vsp += grv
			if grounded:
				if abs(hsp) == 0:
					if move == -spriteh:
						state = states.dash2
						spriteh = -spriteh
					else:
						state = states.normal
						spriteh = -spriteh
		states.dashjump:
			createmachtrail()
			vsp += grv
			if !SInput.key_jump:
				if vsp < 2:
					vsp += 2
			if is_on_floor():
				state = states.dash2
				landdust()
			if is_on_wall():
				wallspeed = -abs(hsp) / 8
				$flashbulb.play()
				state = states.grapple
				animator.play("door")
				animator.frame = 4
				print("grabbed wall at: ", position)
				#hsp = 0
			if SInput.just_key_attack:
				state = states.dropkick
				animator.play("dropkick")
				animator.speed_scale = 0.25
				$swing.play()
				vsp = -12
				hsp = spriteh * 15
			if SInput.just_key_down:
				state = states.screw
				animator.play("screwing")
				animator.speed_scale = 0.4
				vsp = 12
				$swing.stop()
				$swish.play()
		states.grapple:
			vsp = wallspeed
			wallspeed += grv / 4
			if SInput.just_key_jump:
				animator.play("jump")
				animator.frame = 0
				$jump.play()
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
			if SInput.just_key_down:
				$pop.play()
				spriteh = -spriteh
				state = states.jump
				animator.play("fall")
				animator.speed_scale = 0.2
			if is_on_floor():
				state = states.normal
		states.screw:
			createothertrail()
			move = -int(SInput.key_left) - -int(SInput.key_right)
			hsp = lerpf(hsp, move * 8, 30 * delta)
			vsp += grv * 4
			if SInput.just_key_attack:
				state = states.dropkick
				animator.play("dropkick")
				animator.speed_scale = 0.25
				$swing.play()
				vsp = -12
				hsp = movedirection * 15
				if move != 0:
					spriteh = move
			if is_on_floor():
				landdust()
				$flashbulb.play()
				$boing.play()
				state = states.screwbounce
				vsp = -8
				animator.play("jump")
				animator.speed_scale = 0.5
		states.screwbounce:
			move = -int(SInput.key_left) - -int(SInput.key_right)
			hsp = lerpf(hsp, move * 8, 5 * delta)
			if SInput.just_key_attack:
				state = states.dropkick
				animator.play("dropkick")
				animator.speed_scale = 0.25
				$swing.play()
				vsp = -12
				hsp = movedirection * 15
				if move != 0:
					spriteh = move
			vsp += grv
			if is_on_floor():
				if SInput.key_dash:
					landdust()
					if move != 0:
						spriteh = move
					state = states.dash2
				else:
					landdust()
					if move != 0:
						spriteh = move
					state = states.normal
					animator.play("land")
					animator.speed_scale = 0.4
					$step.play()
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
	$CanvasLayer/Control/Label.text = str("(", int(hsp), ", ", int(vsp), ")", ", ", state, ", ", animator.animation, ", ", spriteangle)
	move_and_slide()
	if global.rank < 6:
		$CanvasLayer/Control/Control/rankometer.animation = "default"
		$CanvasLayer/Control/Control/rankometer.speed_scale = 0
		$CanvasLayer/Control/Control/rankometer.frame = global.rank
	if global.rank == 6:
		$CanvasLayer/Control/Control/rankometer.play("full")
		$CanvasLayer/Control/Control/rankometer.speed_scale = 1
	

func statesound() -> void:
	if state == states.dash2:
		if !$dash2.playing:
			$dash2.play()
	else:
		if $dash2.playing:
			$dash2.stop()
	
func _on_animated_sprite_2d_frame_changed() -> void:
	match(state):
		states.normal:
			if animator.animation == "move":
				if animator.frame == 2 or animator.frame == 8:
					$step.play()
					stepdust()
		states.dash2:
			if animator.animation == "mach3":
				if animator.frame == 2:
					if is_on_floor():
						rundust()
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
