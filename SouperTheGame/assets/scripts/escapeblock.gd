extends Node2D

@export var escape :bool
func _ready():
	$AnimatedSprite2D.play("default")

func _process(delta):
	match(escape):
		true:
			match(global.escape):
				true:
					$AnimatedSprite2D.modulate.a8 = 255
					$CBox/CollisionShape2D.disabled = false
				false:
					$AnimatedSprite2D.modulate.a8 = 120
					$CBox/CollisionShape2D.disabled = true
		false:
			match(global.escape):
				false:
					$AnimatedSprite2D.modulate.a8 = 255
					$CBox/CollisionShape2D.disabled = false
				true:
					$AnimatedSprite2D.modulate.a8 = 120
					$CBox/CollisionShape2D.disabled = true
