extends Node2D

@onready var animator := $AnimatedSprite2D
@onready var animate := $AnimationPlayer
var target = null
var colors := [Color8(248, 0, 0, 255),
		  Color8(152, 80, 248, 255),
		  Color8(96, 208, 72, 255)]


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("trail")
	$AnimatedSprite2D.material.set_shader_parameter("real_color", colors[randi() % colors.size()])
	pass # Replace with function body.

#func _process(_delta):
	#if target is Player:
		#if target.state != target.states.dash2:
			#queue_free()
			#print(self.name, " destoryed!")
# Called every frame. 'delta' is the elapsed time since the previous frame.
