extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var cracked = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	$cracked.position.x = 0 + rand_range(-2,2)
	$cracked.position.y = 0 + rand_range(-2,2)
	$cracked.visible = cracked
	$uncracked.visible = !cracked
	if $Area2D.overlaps_body(objplayer):
		if not cracked:
			if objplayer.is_on_floor():
				cracked = true
				$change.play()
				$Timer.start()
				$Area2D/CollisionShape2D.disabled = true
	pass

func hurteffect():
	var whiteflash = preload("res://assets/objects/hurtpartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x + 128
	ghost.position.y = self.position.y + 16
	ghost.amount = 500

func _on_Timer_timeout():
	hurteffect()
	createdead1(0, 0)
	$change4.play()
	randomize()
	$change2.play()
	$CollisionShape2D.disabled = true
	$uncracked.modulate.a8 = 0
	$cracked.modulate.a8 = 0
	$restoretimer.start()
	pass # Replace with function body.

func createdead1(velocityx, rotatespeed):
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x + 128
	ghost.position.y = self.position.y + 16
	ghost.velocity.y = -rand_range(-500,-900) / 1.5
	ghost.velocity.x = velocityx
	ghost.spinamount = rotatespeed
	ghost.sprite.texture = load("res://assets/sprites/white.png")
	ghost.sprite.scale.x = 8
	ghost.sprite.scale.y = 1

func _on_restoretimer_timeout():
	cracked = false
	$CollisionShape2D.disabled = false
	$uncracked.modulate.a8 = 143
	$cracked.modulate.a8 = 143
	$change3.play()
	$Area2D/CollisionShape2D.disabled = false
	pass # Replace with function body.
