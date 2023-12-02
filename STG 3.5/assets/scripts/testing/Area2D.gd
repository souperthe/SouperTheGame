extends Area2D


# Declare member variables here. Examples:
# var a = 2
var player
var wentin = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	wentin = true
	player = body
	queue_free()


func _on_Area2D_body_exited(body):
	#player = body
	#queue_free()
	#wentin = true
	pass
	
func _physics_process(delta):
	if wentin:
		player.cutscene()
	

