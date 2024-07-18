extends Node2D

@onready var animator = $AnimatedSprite2D
@onready var animate = $AnimationPlayer
var target = null


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("trail")
	pass # Replace with function body.

func _process(_delta):
	if target is Player:
		if target.state != target.states.dash2:
			queue_free()
			print(self.name, " destoryed!")
# Called every frame. 'delta' is the elapsed time since the previous frame.
