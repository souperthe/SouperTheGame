extends PlayerState


export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
var fadetowhite = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.modulate = Color(0, 0, 0, 1)
	animation_player.play("exitdoor")
	player.velocity.x = 0
	player.velocity.y = 0
	player.disabletitlt = true
	fadetowhite = true
	
func physics_update(_delta: float) -> void:
	footstepsfx()
	player.velocity.y += 5
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	if fadetowhite and player.modulate.r8 < 255:
		var amount = 300 * _delta
		player.modulate.r8 += amount
		player.modulate.b8 += amount
		player.modulate.g8 += amount
		player.modulate.a8 += amount
	if player.animatonframes == 11:
		state_machine.transition_to("Idle")
		global.combotimer.paused = false
		player.candoor = 1
		
		
func footstepsfx():
	#print(sfxnothasplayed)
	if player.animatonframes == 3 or player.animatonframes == 7:
		if !player.sfxfoot.playing:
			player.sfxfoot.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
