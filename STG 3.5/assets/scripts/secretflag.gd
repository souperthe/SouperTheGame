extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var found = false


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
	ghost.position.x = self.position.x + 50
	ghost.position.y = self.position.y
	ghost.number = str(amount)
	
func _process(delta):
	if overlaps_body(objplayer):
		if !found:
			found = true
			global.secretsfound += 1
			global.addscore(1000)
			numberthing("+1000")
			global.collectablesroom.append(global.targetRoom2 + name)
			$AnimatedSprite.play("found")
			$yay.play()
	pass
