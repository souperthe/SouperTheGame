extends ColorRect
 
 
signal transition_in_done
signal transition_out_done
 
 
onready var animation_player = $AnimationPlayer

func _ready():
	visible = false
 
 
func transition_in():
	animation_player.play("in")
 
 
func transition_out():
	animation_player.play("out")
	
func reset():
	animation_player.play("RESET")
 
 
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "transition_in":
		emit_signal("transition_in_done")
	elif anim_name == "out":
		emit_signal("transition_out_done")
