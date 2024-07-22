extends CharacterBody2D
class_name Baddie

@onready var animator := $animator
var deadsprite := "res://assets/images/otheranimated/testenemy/testenemy_0003.png"
var hsp := 0.0
var vsp := 0.0
var grv := 0.6
var health := 1
var dead := false
enum states {
	normal,
	inactive,
	stun,
	attack
}
var state := states.normal
var directipn := 1


func particals():
	#var hvel := 15
	if $baddiestuff.onscreen:
		camera.camerashake(10, 1)
	yeah()
	yeah()
		

func _ready():
	directipn = global.choose_randomly([1,-1])
	if global.baddieroom.has(global.targetscene + name):
		queue_free()
		print(name, " removed", ", in: ", global.targetscene.get_file())
	floor_constant_speed = true
	floor_snap_length = 64

func destroy(velo, _killedfrom) -> void:
	if !dead:
		global.createdeadthing(position, deadsprite, velo, randf_range(-15,-10))
		global.baddieroom.append(global.targetscene + name)
		queue_free()
		dead = true
		global.score += 5
		particals()
		
		
func yeah() -> void:
	var hvel := 15
	global.createobject("res://assets/objects/bangeffect.tscn", position, 0, Vector2(2, 2))
	global.oneshot_sfx("res://assets/sounds/punching.tres", position, -5)
	global.createdeadthing(position, "res://assets/images/otheranimated/hurtpeices/hurtpeices_0001.png", randf_range(hvel,-hvel), randf_range(-17,-8))
	global.createdeadthing(position, "res://assets/images/otheranimated/hurtpeices/hurtpeices_0002.png", randf_range(hvel,-hvel), randf_range(-17,-8))
	global.createdeadthing(position, "res://assets/images/otheranimated/hurtpeices/hurtpeices_0003.png", randf_range(hvel,-hvel), randf_range(-17,-8))
	global.createdeadthing(position, "res://assets/images/otheranimated/hurtpeices/hurtpeices_0004.png", randf_range(hvel,-hvel), randf_range(-17,-8))
	global.createdeadthing(position, "res://assets/images/otheranimated/hurtpeices/hurtpeices_0005.png", randf_range(hvel,-hvel), randf_range(-17,-8))
	global.createdeadthing(position, "res://assets/images/otheranimated/hurtpeices/hurtpeices_0006.png", randf_range(hvel,-hvel), randf_range(-17,-8))
	global.createdeadthing(position, "res://assets/images/otheranimated/hurtpeices/hurtpeices_0007.png", randf_range(hvel,-hvel), randf_range(-17,-8))
	global.createdeadthing(position, "res://assets/images/otheranimated/hurtpeices/hurtpeices_0008.png", randf_range(hvel,-hvel), randf_range(-17,-8))


func _physics_process(delta):
	match(state):
		states.normal:
			if !is_on_floor():
				vsp += grv
			hsp = directipn * 3
			turn()
	$baddiestuff.scale.x = directipn
	match(directipn):
		1:
			animator.flip_h = false
		-1:
			animator.flip_h = true
	velocity.x = (hsp * 4000) * delta
	velocity.y = (vsp * 4000) * delta
	move_and_slide()
	
	
func turn():
	if $baddiestuff/wallcheck.is_colliding() or !$baddiestuff/floorcheck.is_colliding():
		directipn = -directipn
	
	
	
	

	
