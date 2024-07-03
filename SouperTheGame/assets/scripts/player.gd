extends CharacterBody2D
class_name Player

@onready var animator = $AnimatedSprite2D
var grounded = false
enum states {
	normal,
	jump
}
var state = states.normal
var hsp = 0
var vsp = 0
var grv = 0.6


func _ready():
	animator.play("idle")
	animator.speed_scale = 0.15
	
func _physics_process(delta):
	match(state):
		states.normal:
			var move = -int(SInput.key_left) - -int(SInput.key_right)
			hsp = move * 8
			if move != 0:
				animator.scale.x = move
			if SInput.just_key_jump:
				state = states.jump
				vsp = -15
		states.jump:
			var move = -int(SInput.key_left) - -int(SInput.key_right)
			hsp = lerpf(hsp, move * 8, 10 * delta)
			vsp += grv
			if grounded:
				if vsp > 0:
					state = states.normal
	grounded = is_on_floor()
	velocity.x = hsp * 60
	velocity.y = vsp * 60
	move_and_slide()
