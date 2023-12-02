extends Area2D

export (String) var targetdoor
export (String) var targetscene
var overdoor = false
var player
var doornotentered = true
onready var timer = $timer
var gotodoor = false
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
	#("indoor")
	if body is Player:
		if doornotentered:
			body.makethingvisible()
		player = body
		$AnimatedSprite.play("indoor")
		overdoor = true


func _on_Door_body_exited(_body):
	if _body is Player:
		if doornotentered:
			_body.makethingnotvisible()
		$AnimatedSprite.play("outdoor")
		#print("outdoor")
		overdoor = false
	
func _physics_process(_delta):
	if overdoor and player.candoor and doornotentered:
		if Input.is_action_just_pressed(player.input_up):
			player.makethingnotvisible()
			global.targetdoor = targetdoor
			doornotentered = true
			player.enterdoor()
			player.position.x = position.x
			yield(get_tree().create_timer(0.5), "timeout")
			ct._tin()
			timer.start()



func _on_timer_timeout():
	doornotentered = false
	#ct._tout()
	global.room_goto(targetscene, targetdoor)
	ct._tout()
	player.exitdoor()
