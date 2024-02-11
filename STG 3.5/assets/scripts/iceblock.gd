extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var cracked = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	$uncracked.visible = !cracked
	$cracked.visible = cracked
	if $Area2D.overlaps_body(objplayer):
		if not cracked:
			cracked = true
			$change.play()
			$Timer.start()
	pass

func hurteffect():
	var whiteflash = preload("res://assets/objects/hurtpartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x + 32
	ghost.position.y = self.position.y + 32
	ghost.amount = 500

func _on_Timer_timeout():
	hurteffect()
	$change2.play()
	$CollisionShape2D.disabled = true
	$uncracked.modulate.a8 = 0
	$cracked.modulate.a8 = 0
	pass # Replace with function body.
