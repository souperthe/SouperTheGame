extends Baddie




# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	health = 3
	maxhealth = health
	deadsprite = "res://assets/sprites/enemys/testicle/testicle0003.png"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	match(state):
		states.normal:
			if is_on_floor():
				velocity.x = numdirection * speed
				wander()
				getscared()
			if velocity.x != 0 and is_on_floor():
				animator.play("walk")
			else:
				animator.play("default")
			if !is_on_floor():
				animator.play("fall")
				velocity.x = lerp(velocity.x, 0, 3 * delta)
