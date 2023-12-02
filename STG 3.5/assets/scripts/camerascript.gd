extends Camera2D

onready var p1 = objplayer
onready var p2 = presobjs.player2

var zoomin = 1
var zoommax = 2
var counter = 0
var rotates = 0 
var rotatesamount = 5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tet = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().get_current_scene().get_node(global.targetdoor):
		position.x = get_tree().get_current_scene().get_node(global.targetdoor).position.x
		position.y = get_tree().get_current_scene().get_node(global.targetdoor).position.y
	if !get_tree().get_current_scene().get_node(global.targetdoor):
		position.x = 0
		position.y = 0
	pass # Replace with function body.


func _process(_delta):
	global.camera = self
	rotatesamount = global.camerarotamount
	if global.panic:
		escapetilt()
		var idkanymore = cos(rotates)
		if global.panic:
			rotates += 1 * _delta
			rotation_degrees = (idkanymore * rotatesamount)
	if !global.panic:
		$AnimationPlayer.play("reset")
		$CanvasLayer/wavy.visible = false
		rotation_degrees = 0
	smoothing_speed = global.cameraspeed 
	smoothing_enabled = global.camerasmoothing
	if not presobjs.player2:
		zoom.x = global.camerazoom
		zoom.y = global.camerazoom
		position.x = objplayer.position.x
		position.y = objplayer.position.y
	if presobjs.player2:
		position = (objplayer.position + presobjs.player2.position) / Vector2(2,2)
		zoom.x = max(zoomin, abs((objplayer.position.x-presobjs.player2.position.x)))/800
		zoom.y = max(zoomin, abs((objplayer.position.x-presobjs.player2.position.x)))/800
		limit_bottom = 10000000
		limit_right = 10000000
		limit_left = -10000000
		limit_top = -10000000
		if zoom.x < zoomin:
			zoom.x = zoomin
			zoom.y = zoomin
			
		
			
func escapetilt():
	$CanvasLayer/wavy.visible = true
	$AnimationPlayer.play("panic")
	
#	pass
