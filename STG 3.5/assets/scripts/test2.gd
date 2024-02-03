extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if objplayer.playercharacter == "SM":
		texture = load("res://assets/sprites/animated/hurtblock/hurtblock_0001.png")
	if objplayer.playercharacter == "S":
		texture = load("res://assets/sprites/animated/panicswitchblock/switchblock0001.png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.scale = lerp(self.scale, Vector2(1,1),0.1)
	if $Area2D.overlaps_body(objplayer):
		if !objplayer.currentstate == "peelslip":
			self.scale = Vector2(1.2, 1.2)
			$AudioStreamPlayer2D.play()
			#objplayer.changestate("peelslip")
			if objplayer.playercharacter == "SM":
				objplayer.switchplayer("souper")
			if objplayer.playercharacter == "S":
				objplayer.switchplayer("sockman")
			queue_free()
	pass
