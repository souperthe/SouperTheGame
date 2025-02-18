extends CharacterBody2D
class_name Baddie

@onready var animator := $animator
var deadsprite := "res://assets/images/otheranimated/testenemy/testenemy_0003.png"
var hsp := 0.0
var vsp := 0.0
var grv := 0.6
var health := 1
var dead := false
var lastfloor := Vector2()
var spriteangle := 0.0
enum states {
	normal,
	inactive,
	stun,
	attack
}
var state := states.normal
var directipn := 1
var stunstime := 60

		

func _ready():
	animator.play("default")
	directipn = global.choose_randomly([1,-1])
	if global.baddieroom.has(global.targetscene + name):
		queue_free()
		print(name, " removed", ", in: ", global.targetscene.get_file())
	#floor_constant_speed = true
	#floor_snap_length = 64

func destroy(velo, _killedfrom) -> void:
	if !dead:
		global.createdeadthing(position, deadsprite, velo, randf_range(-15,-10))
		global.baddieroom.append(global.targetscene + name)
		queue_free()
		dead = true
		global.score += 5
		yeah()
		yeah()
		
		
func yeah() -> void:
	var hvel := 15
	global.createobject("res://assets/objects/bangeffect.tscn", position, 0, Vector2(2, 2))
	for i in range(8):
		var xvelo := randf_range(15,-15)
		var yvelo := randf_range(-5,-15)
		var sprite := str("res://assets/images/otheranimated/hurtpeices/hurtpeices_000", i + 1, ".png")
		global.createdeadthing(position, sprite, xvelo, yvelo)
func _physics_process(delta):
	if $baddiestuff.onscreen:
		process(delta)

func process(delta):
	match(state):
		#states.normal:
			#if !is_on_floor():
				#vsp += grv
			#hsp = directipn * 3
			#turn()
		states.stun:
			vsp += grv
			animator.play("stun")
			if is_on_floor():
				stunstime -= 65 * delta
				hsp = global.approach(hsp, 0, 35 * delta)
			if is_on_wall():
				hsp = -hsp
			if stunstime < 0:
				state = states.normal
				animator.play("default")
				hsp = 0
	$baddiestuff.scale.x = directipn
	match(directipn):
		1:
			animator.flip_h = false
		-1:
			animator.flip_h = true
	velocity.x = (hsp * 4000) * delta
	velocity.y = (vsp * 4000) * delta
	move_and_slide()
	
	
func getspriteangle(dlt):
	if is_on_floor():
		lastfloor = position
		var floornormal = get_floor_normal()
		#spriteangle = abs(rad_to_deg(get_floor_angle()))
		spriteangle = rad_to_deg(floornormal.angle() + deg_to_rad(90))
	else:
		spriteangle = 0
	animator.rotation_degrees = lerpf(animator.rotation_degrees, spriteangle, 15 * dlt)
	
func turn():
	if $baddiestuff/wallcheck.is_colliding() or !$baddiestuff/floorcheck.is_colliding():
		directipn = -directipn
	
	
	
	

	
