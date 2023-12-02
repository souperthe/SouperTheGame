extends AnimatedSprite
var modifer = 0

var colors = [Color(1.0, 0.0, 0.0, 1.0),
		  Color(0.0, 1.0, 0.0, 1.0),
		  Color(0.0, 0.0, 1.0, 0.0)]

func _ready():
	$Tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 0.2, 3, 1)
	$Tween.start()
	#material.get_shader().set_shader_param(flash_modifier, 0)
	#modulate = colors[randi() % colors.size()]
	
	

func _on_Tween_tween_all_completed():
	queue_free()
	#("uncreated trail")
	pass
	
#func _process(delta):
	#self.frame = objplayer.animator.get_frame()
