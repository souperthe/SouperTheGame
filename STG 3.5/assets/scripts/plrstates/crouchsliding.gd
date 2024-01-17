extends PlayerState

export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func enter(_msg := {}) -> void:
	animation_player.play("diveslide")
	player.sfxslide.play()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func physics_update(delta: float) -> void:
	player.trail()
	#player.sfxslide.pitch_scale =  abs(player.velocity.x) / 700
	#player.sfxslide.pitch_scale = abs(-player.velocity.x / 100)
	if player.is_on_floor():
		player.speedpart.emitting = true
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector2.UP)
	if player.is_on_floor() and Input.is_action_just_pressed(player.input_jump):
		state_machine.transition_to("mach_jump", {do_jump = true})
	if !Input.is_action_pressed(player.input_down) and player.canuncrouch:
		state_machine.transition_to("Mach2")
	if player.is_on_wall():
		state_machine.transition_to("bumpwall")
		#player.hitwall.play()
		player.mach3.stop()
	if !player.is_on_floor():
		state_machine.transition_to("diving")
		
func exit() -> void:
	player.speedpart.emitting = false
	player.pmachbox.disabled = true
	player.machbox.disabled = true
	player.emachbox.disabled = true
	player.mach3.stop()
#func _process(delta):
#	pass
