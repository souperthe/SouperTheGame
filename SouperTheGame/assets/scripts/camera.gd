extends Camera2D

var target = plr
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = target.position.x
	position.y = lerp(position.y, target.position.y, 15 * delta) - 2
	pass
