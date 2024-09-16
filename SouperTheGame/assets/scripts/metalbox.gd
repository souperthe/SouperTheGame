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
	for i in range(6):
		var xvelo := randf_range(25,-25)
		var yvelo := randf_range(-15,-5)
		var sprite := str("res://assets/images/otheranimated/metalpeices/metalpeice_", i + 1, ".png")
		global.createdeadthing(position, sprite, xvelo, yvelo)
	for i in range(6):
		var xvelo := randf_range(25,-25)
		var yvelo := randf_range(-15,-5)
		var sprite := str("res://assets/images/otheranimated/metalpeices/metalpeice_", i + 1, ".png")
		global.createdeadthing(position, sprite, xvelo, yvelo)
	
	queue_free()
