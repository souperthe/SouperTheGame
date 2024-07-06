extends Camera2D

var target = plr
var of = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	of = clamp(lerpf(of, plr.vsp * 3, 5 * delta), -64, 64)
	position.x = target.position.x
	position.y = target.position.y - 30 - of
