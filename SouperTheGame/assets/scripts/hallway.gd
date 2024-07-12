extends Node2D

@export var target_scene :String
@export var target_door :String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func createtransition():
	var whiteflash = preload("res://assets/objects/fadetransistion.tscn")
	var ghost: CanvasLayer = whiteflash.instantiate()
	global.add_child(ghost)
	ghost.targetroom = target_scene
	ghost.targetdoor = target_door
	ghost.door = false

func _on_area_2d_body_entered(body):
	if body is Player:
		queue_free()
		createtransition()
	pass # Replace with function body.
