extends Node2D

var onscreen = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var anchorY = -56
var frequency = 0.1
var amplitude = 20
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$enemyhealth/pivot.position.y = anchorY + sin(timer*frequency)*15
	#$enemyhealth/pivot.scale.y = 1 + (sin(timer*frequency)*15 / 45)
	timer += 0.5
#	pass


func _on_VisibilityNotifier2D_screen_entered():
	onscreen = true
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	onscreen = false
	pass # Replace with function body.


func _on_lavacheck_body_entered(_body):
	owner.dead(0)
	owner.punchsound()
	pass # Replace with function body.


func _on_hurtcheck_body_entered(body):
	if not body.assignedtoplayer:
		owner.dead(0)
		owner.punchsound()
	pass # Replace with function body.
