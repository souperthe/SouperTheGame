extends RigidBody2D


var canhurt = 1
onready var colcheck = $CollisionShape2D
export (bool) var assignedtoplayer


func _ready():
	pass
	
func _physics_process(_delta):
	if canhurt:
		$CollisionShape2D.disabled = false
		modulate.a8 = 255
	if !canhurt:
		$CollisionShape2D.disabled = true
		modulate.a8 = 125

