extends Node2D

var escape = false
var score = 0
var combo = 0
var targetdoor = "1"
var targetscene = null
var showdebug = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func startroom():
	var door = roomhandler.currentscene.get_node(str("door", targetdoor))
	plr.position = door.position
	camera.position = plr.position
	pass
