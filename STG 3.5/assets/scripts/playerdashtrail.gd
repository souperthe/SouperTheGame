extends AnimatedSprite
var modifer = 0
var time = 60

var colors = [Color8(248, 0, 0, 255),
		  Color8(152, 80, 248, 255),
		  Color8(96, 208, 72, 255)]

func _ready():
	modulate = colors[randi() % colors.size()]
	$Tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 0.4, 0, 1)
	$Tween.start()
	#material.get_shader().set_shader_param(flash_modifier, 0)
	#modulate = colors[make_color_hsv(randi() % colors.size())]
	
func _physics_process(_delta):
	playing = false
	
	

func _on_Tween_tween_all_completed():
	queue_free()
	#("uncreated trail")



func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
	pass # Replace with function body.
