extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var canzoomin = false

func _ready():
	$CanvasLayer/Control.visible = true
	$Timer.start()
	$CanvasLayer/Control/BackBufferCopy2/mask.scale = Vector2(30,30)
	$CanvasLayer/Control/Light2D.energy = 0.7
	$CanvasLayer/ParallaxBackground.visible = true


# Called when the node enters the scene tree for the first time.
func _process(_delta):
	if global.panic:
		queue_free()
	var thing = $CanvasLayer/ParallaxBackground/ParallaxLayer/ColorRect
	var player_pos = objplayer.get_global_transform_with_canvas()
	var spawn_pos = player_pos.get_origin()
	$CanvasLayer/Control/BackBufferCopy2/mask.position.x = clamp(spawn_pos.x - 95, -900, 900)
	$CanvasLayer/Control/BackBufferCopy2/mask.position.y = clamp(spawn_pos.y - 85, -101, 441)
	if canzoomin and $CanvasLayer/Control/BackBufferCopy2/mask.scale != Vector2(1,1):
		$CanvasLayer/Control/BackBufferCopy2/mask.scale = lerp($CanvasLayer/Control/BackBufferCopy2/mask.scale, Vector2(2,2), 5 * _delta)
		$CanvasLayer/Control/Light2D.energy = lerp($CanvasLayer/Control/Light2D.energy, 0.1, 0.5 * _delta)
		thing.modulate.a8 = lerp(thing.modulate.a8, -5, 1 * _delta)


func _on_Timer_timeout():
	canzoomin = true
	pass # Replace with function body.
