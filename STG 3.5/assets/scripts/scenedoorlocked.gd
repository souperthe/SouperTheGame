extends Area2D

export (String) var targetdoor
export (String) var targetscene
var overdoor = false
var unlocked = false
var player
var doornotentered = true
onready var timer = $timer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.othersroom.has(global.targetRoom2 + name)):
		unlocked = true
	$AnimatedSprite.play("locked")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Door_body_entered(body):
	#("indoor")
	if body is Player:
		if doornotentered and objplayer.haskey or unlocked:
			body.makethingvisible()
		player = body
		overdoor = true


func _on_Door_body_exited(body):
	#print("outdoor")
	if body is Player:
		if doornotentered and objplayer.haskey or unlocked:
			body.makethingnotvisible()
		overdoor = false
	
func _physics_process(delta):
	if unlocked:
		$AnimatedSprite.play("outdoor")
	if overdoor and player.candoor and doornotentered:
		if Inputs.just_key_up:
			if objplayer.haskey == true:
				global.othersroom.append(global.targetRoom2 + name)
				player.makethingnotvisible()
				$AnimatedSprite.play("outdoor")
				global.targetdoor = targetdoor
				objplayer.haskey = false
				doornotentered = true
				player.enterdoor()
				player.position.x = position.x
				yield(get_tree().create_timer(1.5), "timeout")
				ct._tin()
				timer.start()
			if unlocked:
				player.makethingnotvisible()
				global.targetdoor = targetdoor
				objplayer.haskey = false
				doornotentered = true
				player.enterdoor()
				player.position.x = position.x
				yield(get_tree().create_timer(0.5), "timeout")
				ct._tin()
				timer.start()
				timer.wait_time = global.doortime



func _on_timer_timeout():
	doornotentered = false
	#ct._tout()
	global.room_goto(targetscene, targetdoor)
	ct._tout()
	player.exitdoor()
