extends RigidBody2D


var canhurt = 1
onready var colcheck = $CollisionShape2D


func _ready():
	pass
	
func _physics_process(_delta):
	if canhurt:
		$CollisionShape2D.disabled = false
	if !canhurt:
		$CollisionShape2D.disabled = true

