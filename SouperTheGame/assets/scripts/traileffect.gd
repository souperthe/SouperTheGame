extends Node2D

@onready var animator = $AnimatedSprite2D
@onready var animate = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("trail")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
