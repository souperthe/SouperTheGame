extends Node2D



func _ready():
	if global.collectroom.has(global.targetscene + name):
		queue_free()
		print(name, " removed", ", in: ", global.targetscene.get_file())


func _on_collision_body_entered(body):
	if body is Player:
		global.score += 25
		global.collectroom.append(global.targetscene + name)
		queue_free()
		global.collectsfx(1)
	pass # Replace with function body.
