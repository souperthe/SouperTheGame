extends Baddie




# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	health = 1
	deadsprite = "res://assets/sprites/enemys/forkdemon/forkdemon_0010.png"
	#if global.hardmode:
		#health = 4
		#maxhealth = health
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(_delta):
	$enemyesentials/hurtblock.visible = global.showcolloisions
	$enemyesentials/hurtblock.canhurt = is_on_floor() and !state == states.scared and !state == states.stun and !state == states.inactive
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
