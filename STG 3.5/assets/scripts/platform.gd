extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var thing


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	self.visible = global.showcolloisions
	thing = position.y < objplayer.position.y
	ladderthing()
		
func ladderthing():
	if objplayer.currentstate == ("Ladder"):
		#objplayer.collide.disabled = true
		pass
		#$CollisionShape2D.disabled = true
	if !objplayer.currentstate == ("Ladder"):
		#objplayer.collide.disabled = false
		pass
		#$CollisionShape2D.disabled = false
		

