extends State


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var _boss
onready var boss:KinematicBody2D = get_node(_boss)
var speed = 950


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	boss.animator.play("punch")
	boss.punchurt.disabled = false
	boss.velocity.y = objplayer.velocity.y

func physics_update(delta: float) -> void:
	boss.velocity.y += boss.gravity * delta
	boss.velocity = boss.move_and_slide(boss.velocity, Vector2.UP, true)
	boss.trail()
	if boss.onwall:
		state_machine.transition_to("attack")
		boss.faceplayer()
	if boss.face:
		boss.velocity.x = -speed
	if !boss.face:
		boss.velocity.x = speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
