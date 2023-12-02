extends State


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var _boss
onready var boss:KinematicBody2D = get_node(_boss)


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	boss.animator.play("idle")
	pass # Replace with function body.
	
	
func physics_update(delta: float) -> void:
	boss.velocity.y += boss.gravity * delta
	boss.velocity = boss.move_and_slide(boss.velocity, Vector2.UP, true)
	if boss.canfight:
		state_machine.transition_to("attack")
	
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
