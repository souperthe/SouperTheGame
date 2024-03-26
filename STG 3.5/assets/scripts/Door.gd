extends Area2D

export (NodePath) var targetdoor
onready var targetDoor = get_node(targetdoor)
var overdoor = false
var player
var doornotentered = true
onready var timer = $timer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Door_body_entered(body):
	#("indoor
	if body is Player:
		if doornotentered:
			body.makethingvisible()
		player = body
		$AnimatedSprite.play("indoor")
		overdoor = true


func _on_Door_body_exited(body):
	if body is Player:
		if doornotentered:
			body.makethingnotvisible()
		$AnimatedSprite.play("outdoor")
		#print("outdoor")
		overdoor = false
	
func _physics_process(delta):
	if overdoor and player.candoor and doornotentered:
		if Inputs.just_key_up:
			player.makethingnotvisible()
			player.position.x = position.x
			doornotentered = true
			player.enterdoor()
			yield(get_tree().create_timer(1.0), "timeout")
			ct._tin()
			timer.start()



func _on_timer_timeout():
	doornotentered = false
	ct._tout()
	player.position = targetDoor.position
	player.exitdoor()
