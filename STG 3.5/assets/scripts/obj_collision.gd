extends StaticBody2D







# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.is_debug_build():
		$sprite.visible = true
	if not OS.is_debug_build():
		$sprite.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
