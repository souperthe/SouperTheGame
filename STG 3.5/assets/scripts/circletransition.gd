extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _tin():
	#$in.play()
	$circletrans.transition_in()
	$circletrans.visible = true
 
 
func _tout():
	#$out.play()
	$circletrans.transition_out()
	$circletrans.visible = true
	
func _treset():
	$circletrans.reset()
	$circletrans.visible = false
	
func _fout():
	$fadetrans.fade_out()
	$fadetrans.visible = true
	
func _fin():
	$fadetrans.fade_in()
	$fadetrans.visible = true
	
	
func _freset():
	$fadetrans.fade_out()
	$fadetrans.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
