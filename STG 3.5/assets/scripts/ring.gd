extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var anchorY = 5
var frequency = 0.1
var amplitude = 20
var timer = 0
var player
var used = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.collectablesroom.has(global.targetRoom2 + name)):
		used = true
	pass # Replace with function body.


func _process(delta):
	if used:
		$thing.modulate.a8 = 95
	if not used:
		$thing.position.y = anchorY + sin(timer*frequency)*amplitude
		timer += 0.5
	if overlaps_body(objplayer):
		if not used:
			used = true
			global.addscore(1000)
			global.collectablesroom.append(global.targetRoom2 + name)
			global.resetcombo()
			$yay.play()
