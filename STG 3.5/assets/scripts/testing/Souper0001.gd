extends Sprite


func _ready():
	pass
	
	
	
	
	
	
	
func _body_entered(body: Node):
	if body is Player:
		objplayer.hurtplayer()
