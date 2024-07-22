extends Camera2D

var target := plr
var of := 0.0
var s_amount := 0.0
var sf_amount := 0.0
var locked := false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if s_amount > 0:
		s_amount = global.approach(s_amount, 0, sf_amount)
		#print(s_amount)
		offset.x = randi_range(s_amount, -s_amount)
		offset.y = randi_range(s_amount, -s_amount)
	of = clamp(lerpf(of, plr.vsp * 3, 5 * delta), -64, 64)
	if !locked:
		position.x = target.position.x
		position.y = target.position.y - 30
	
	
func camerashake(amount, time):
	s_amount = amount
	sf_amount = time
