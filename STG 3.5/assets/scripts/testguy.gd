extends Baddie


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	health = 5
	deadsprite = "res://assets/sprites/animated/testenemy/dead.png"
	pass # Replace with function body.


func _physics_process(delta):
	match(state):
		states.normal:
			if is_on_floor():
				velocity.x = numdirection * speed
				wander()
			#if velocity.x != 0 and is_on_floor():
				#animator.play("walk")
			#else:
				#animator.play("default")
			if !is_on_floor():
				animator.play("stun")
				velocity.x = lerp(velocity.x, 0, 3 * delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
