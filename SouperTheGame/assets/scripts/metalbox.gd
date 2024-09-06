extends CharacterBody2D
class_name MetalBlock

func _ready():
	if global.blockroom.has(global.targetscene + name):
		queue_free()
		print(name, " removed", ", in: ", global.targetscene.get_file())

func destroy() -> void:
	global.score += 5
	var postion := Vector2(self.position.x + 32, self.position.y + 32)
	var hvel := 15
	#var yvel := randf_range(-20,-8)
	#particals()
	global.blockroom.append(global.targetscene + name)
	global.createobject("res://assets/objects/bangeffect.tscn", postion, 0, Vector2(1.5, 1.5))
	global.oneshot_sfx("res://assets/sounds/metalrandomized.tres", postion, -5)
	camera.camerashake(30, 0.1)
	global.createdeadthing(postion, "res://assets/images/otheranimated/metalpeices/metalpeice_1.png", randf_range(hvel,-hvel), randf_range(-10,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/metalpeices/metalpeice_2.png", randf_range(hvel,-hvel), randf_range(-10,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/metalpeices/metalpeice_3.png", randf_range(hvel,-hvel), randf_range(-10,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/metalpeices/metalpeice_4.png", randf_range(hvel,-hvel), randf_range(-10,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/metalpeices/metalpeice_5.png", randf_range(hvel,-hvel), randf_range(-10,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/metalpeices/metalpeice_6.png", randf_range(hvel,-hvel), randf_range(-10,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/metalpeices/metalpeice_1.png", randf_range(hvel,-hvel), randf_range(-10,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/metalpeices/metalpeice_2.png", randf_range(hvel,-hvel), randf_range(-10,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/metalpeices/metalpeice_3.png", randf_range(hvel,-hvel), randf_range(-10,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/metalpeices/metalpeice_4.png", randf_range(hvel,-hvel), randf_range(-10,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/metalpeices/metalpeice_5.png", randf_range(hvel,-hvel), randf_range(-10,-8))
	global.createdeadthing(postion, "res://assets/images/otheranimated/metalpeices/metalpeice_6.png", randf_range(hvel,-hvel), randf_range(-10,-8))
	
	queue_free()
