extends Collideable

func _process(_delta):
	$playercollision/CollisionShape2D.disabled = plr.state == plr.states.ladder
	pass
