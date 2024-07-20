extends Node2D



#func _process(_delta):
	#if $collision.overlaps_body(plr):
		#global.score += 25
		#print("YOU GOT 25 POINTS!!")
		#queue_free()
		##SPEGHETTI CODE


func _on_collision_body_entered(body):
	if body is Player:
		global.score += 25
		print("YOU GOT 25 POINTS!!")
		queue_free()
	pass # Replace with function body.
