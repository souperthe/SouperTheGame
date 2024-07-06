extends Collideable

func _process(delta):
	$playercollision/CollisionShape2D.disabled = plr.state == plr.states.ladder
	pass
