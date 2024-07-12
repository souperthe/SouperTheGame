extends StaticBody2D
class_name Collideable


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$BlankBlock.visible = global.showdebug
	pass
