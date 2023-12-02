extends State


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var _boss
onready var boss:KinematicBody2D = get_node(_boss)

# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	boss.animator.play("fall")
	boss.punchurt.disabled = true
	boss.faceplayer()
	boss.velocity.y = -450
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	state_machine.transition_to("attack")
	boss.faceplayer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func physics_update(delta: float) -> void:
	boss.velocity.y += boss.gravity * delta
	boss.velocity = boss.move_and_slide(boss.velocity, Vector2.UP, true)
