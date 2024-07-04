extends CharacterBody2D
class_name Player

@onready var animator = $AnimatedSprite2D
var grounded = false
enum states {
	normal,
	jump,
	actor,
	freefallprep,
	freefalling,
	freefallland
}
var state = states.normal
var hsp = 0
var vsp = 0
var grv = 0.6
var spriteangle
var spriteh = 1
var lastfloor = Vector2()

func landdust():
	var whiteflash = preload("res://assets/objects/landdust.tscn")
	var ghost: Node2D = whiteflash.instantiate()
	roomhandler.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	
func stepdust():
	var whiteflash = preload("res://assets/objects/stepdust.tscn")
	var ghost: Node2D = whiteflash.instantiate()
	roomhandler.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y


func _ready():
	animator.play("idle")
	animator.speed_scale = 0.15
	floor_constant_speed = true
	floor_snap_length = 64
	
var thing = false
	
func _physics_process(delta):
	match(state):
		states.normal:
			var move = -int(SInput.key_left) - -int(SInput.key_right)
			hsp = move * 10
			if move != 0:
				spriteh = move
				animator.play("move")
				if is_on_wall():
					animator.speed_scale = 0.2
				else:
					animator.speed_scale = 0.3
			else:
				animator.play("idle")
				animator.speed_scale = 0.15
			if SInput.just_key_jump:
				animator.play("jump")
				animator.speed_scale = 0.3
				state = states.jump
				thing = false
				$jump.play()
				vsp = -15
			if !is_on_floor():
				state = states.jump
				animator.play("fall")
				animator.speed_scale = 0.2
		states.jump:
			var move = -int(SInput.key_left) - -int(SInput.key_right)
			hsp = lerpf(hsp, move * 8, 12 * delta)
			vsp += grv
			if !SInput.key_jump:
				if animator.animation == "jump":
					if vsp < 2:
						vsp += 2
					#print("thing ", vsp)
			if is_on_floor():
				#if vsp > 1:
					state = states.normal
					$step.play()
					landdust()
					vsp = 0
	grounded = is_on_floor()
	if spriteh == 1:
		animator.flip_h = false
	if spriteh == -1:
		animator.flip_h = true
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
	animator.rotation_degrees = lerpf(animator.rotation_degrees, spriteangle, 15 * delta)
	$CanvasLayer/Control/Label.text = str("(", hsp, ", ", vsp, ")", ", ", state, ", ", animator.animation, ", ", spriteangle)
	move_and_slide()


func _on_animated_sprite_2d_frame_changed():
	match(state):
		states.normal:
			if animator.animation == "move":
				if animator.frame == 2 or animator.frame == 8:
					$step.play()
					stepdust()
	pass # Replace with function body.
