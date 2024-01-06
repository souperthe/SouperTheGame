extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var applyvelo = false


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	player.attacksfx.play()
	player.change.play()
	applyvelo = false
	animation_player.play("sjump_cancle")
	player.machbox.disabled = true
	player.emachbox.disabled = true
	pass # Replace with function body.
	
func physics_update(_delta: float) -> void:
	if not applyvelo:
		player.velocity.y = 0
		player.velocity.x = 0
	if applyvelo:
		if !player.face:
			player.velocity.x = player.speedrun2
		if player.face:
			player.velocity.x = player.speedrun2
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
	player.get_input_direction()
	if player.animatonframes > 4:
		player.disabletitlt = false
		player.sjumpentersfx.play()
		state_machine.transition_to("Mach2")
		if !player.face:
			player.velocity.x = player.speedrun
		if player.face:
			player.velocity.x = -player.speedrun


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
