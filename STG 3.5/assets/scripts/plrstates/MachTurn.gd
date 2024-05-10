extends PlayerState


export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
var done = 0
var pressing
# var b = "text"


func enter(msg := {}) -> void:
	animation_player.play("machturn2")
	if msg.has("two"):
		animation_player.play("machturn2")
	if msg.has("one"):
		animation_player.play("machturn1")
	player.machcancel.play()
	player.mach3.stop()
	player.candoor = 0
	#player.face = !player.face
	
	
func _ready():
	pass # Replace with function body.
	
func physics_update(delta: float) -> void:
	pressing = Inputs.key_left or Inputs.key_right
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	player.velocity.x = lerp(player.velocity.x, 0, 8 * delta)
	
	if player.animatonframes > 3:
		if pressing:
			if player.is_on_floor():
				state_machine.transition_to("Mach2", {do_turn = true})
				player.get_input_direction()
			if !player.is_on_floor():
				state_machine.transition_to("machfall")
				#player.face = !player.face
				#animation_player.flip_h = !animation_player.flip_h
		if !pressing:
			state_machine.transition_to("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
