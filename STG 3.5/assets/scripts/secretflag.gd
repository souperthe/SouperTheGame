extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var found = false
var a = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("unfound")
	if (global.collectablesroom.has(global.targetRoom2 + name)):
		found = true
		$AnimatedSprite.play("foundloop")
	pass # Replace with function body.

func numberthing(amount):
	var dashtrail = preload("res://assets/objects/smallnumber.tscn")
	var ghost: Node2D = dashtrail.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y - 64
	ghost.number = str(amount)
	
	
func _process(delta):
	a = float(0.1 * global.secretsfound / 2)
	if overlaps_body(objplayer):
		if !found:
			found = true
			global.secretsfound += 1
			global.addscore(1000)
			numberthing("+1000")
			global.collectablesroom.append(global.targetRoom2 + name)
			$AnimatedSprite.play("found")
			$yay.play()
			$yay.pitch_scale = $yay.pitch_scale + a
			var rng = global.randi_range(1,3)
			if rng == 3:
				objplayer.voicepositive()
			#OS.alert(str(a), "yea")
	pass
