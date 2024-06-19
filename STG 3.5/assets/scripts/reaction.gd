extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animator = $tv
onready var animator2 = $change
var panicplayed = false
onready var player = objplayer
# Called when the node enters the scene tree for the first time.
func _ready():
	playanim("idle")
	animator2.animation = ("change")
	pass # Replace with function body.

func _process(_delta):
	if player.currentstate == ("peelslip") or player.currentstate == ("peelland") or player.currentstate == ("peelslipbounce"):
		if !animator.animation == ("judgement"):
			playanim("judgement")
	if player.currentstate == ("Mach2") or player.currentstate == ("mach_jump"):
		if !animator.animation == ("mach2"):
			playanim("mach2")
	if player.currentstate == ("Mach3"):
		if !animator.animation == ("mach3"):
			playanim("mach3")
	if player.currentstate == ("Idle") or player.currentstate == ("Air") or player.currentstate == ("tumble") or player.currentstate == ("crouchsliding") or player.currentstate == ("diving") or player.currentstate == ("Run") or player.currentstate == ("MachTurn") or player.currentstate == ("sjump_prep") or player.currentstate == ("fallpound_fall") or player.currentstate == ("bumpwall") or player.currentstate == ("fallpound_start") or player.currentstate == ("grapple"):
		if !animator.animation == ("idle") and global.combo == 0 and not global.panic:
			playanim("idle")
		if !animator.animation == ("escape") and global.panic:
			playanim("escape")
		if !animator.animation == ("combo") and !global.combo == 0 and not global.panic:
			playanim("combo")
	if player.currentstate == ("Hurt") or player.currentstate == ("rollthing"):
		if !animator.animation == ("hurt"):
			playanim("hurt")
	if player.currentstate == ("Noclip"):
		if !animator.animation == ("default"):
			playanim("default")
	if player.currentstate == ("assburned"):
		if !animator.animation == ("assburning"):
			playanim("assburning")
		
		
		
func playanim(animation):
	animator2.frame = 0
	animator.play(animation)
		
		
		
		
		

