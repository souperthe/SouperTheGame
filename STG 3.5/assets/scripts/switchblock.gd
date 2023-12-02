extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if global.panic == true:
		$AnimatedSprite.modulate.a8 = 125
		$CollisionShape2D.disabled = true
	if global.panic == false:
		$AnimatedSprite.modulate.a8 = 255
		$CollisionShape2D.disabled = false
