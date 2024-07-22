extends CharacterBody2D
class_name Grabbable

enum states {
	normal,
	hold,
	thrown
}
var state = states.normal

var hsp := 0.0
var vsp := 0.0
var grv := 0.6
func yeah():
	var postion := position
	var hvel := 16
	global.createdeadthing(postion, "res://assets/images/otheranimated/cratepeices/cratepeices_1.png", randf_range(hvel,-hvel), randf_range(-12,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/cratepeices/cratepeices_2.png", randf_range(hvel,-hvel), randf_range(-12,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/cratepeices/cratepeices_3.png", randf_range(hvel,-hvel), randf_range(-12,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/cratepeices/cratepeices_4.png", randf_range(hvel,-hvel), randf_range(-12,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/cratepeices/cratepeices_5.png", randf_range(hvel,-hvel), randf_range(-12,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/cratepeices/cratepeices_6.png", randf_range(hvel,-hvel), randf_range(-12,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/cratepeices/cratepeices_7.png", randf_range(hvel,-hvel), randf_range(-12,-8))
func destroy() -> void:
	global.score += 5
	var postion := position
	#var yvel := randf_range(-20,-8)
	#particals()
	global.blockroom.append(global.targetscene + name)
	global.createobject("res://assets/objects/bangeffect.tscn", postion, 0, Vector2(1.5, 1.5))
	global.oneshot_sfx("res://assets/sounds/craterandmized.tres", postion, -5)
	#camera.camerashake(15, 1)
	yeah()
	yeah()
	yeah()
	
	queue_free()

func _physics_process(delta):
	#$CPlatform.visible = state == states.normal
	#$CPlatform/playercollision/CollisionShape2D.disabled = state == states.normal
	match(state):
		states.normal:
			if !is_on_floor():
				vsp += grv
			if is_on_floor():
				hsp = lerpf(hsp, 0 * 8, 12 * delta)
				vsp = 0
		states.hold:
			vsp = 0
			hsp = 0
		states.thrown:
			createothertrail()
			if !is_on_floor():
				$AnimatedSprite2D.rotation_degrees += hsp * 40 * delta
				vsp += grv
			if is_on_floor():
				$AnimatedSprite2D.rotation_degrees = 0
				vsp = 0
			if is_on_wall():
				destroy()
	velocity.x = (hsp * 4000) * delta
	velocity.y = (vsp * 4000) * delta
	move_and_slide()


func _on_thing_body_entered(body):
	if body is Baddie:
		if state == states.thrown:
			body.destroy(hsp, position)
	if body is Grabbable:
		if state == states.thrown:
			body.destroy()
	pass # Replace with function body.

func createothertrail() -> void:
	if !$trailtimer.time_left > 0:
		$trailtimer.start()
		

func _on_trailtimer_timeout():
	global.createtrail(self.position, $AnimatedSprite2D, Color8(255,255,255,255), 2)
	pass # Replace with function body.
