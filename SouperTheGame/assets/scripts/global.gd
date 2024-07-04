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
	
func gotoroom(targetroom, selecteddoor):
	roomhandler.scenegoto(targetroom)
	targetdoor = selecteddoor
	
func startroom():
	var door = roomhandler.currentscene.get_node(str("door", targetdoor))
	if is_instance_valid(door):
		plr.position.x = door.position.x
		plr.position.y = door.position.y - 45
		camera.position = plr.position
		print("target door found!: ", door.name, ", ", door.position)
	else:
		print("target door NOT found! missing ", "door", targetdoor)
	var cl_left = roomhandler.currentscene.get_node(str("CL_Left"))
	var cl_right = roomhandler.currentscene.get_node(str("CL_Right"))
	var cl_bottom = roomhandler.currentscene.get_node(str("CL_Bottom"))
	var cl_top = roomhandler.currentscene.get_node(str("CL_Top"))
	if is_instance_valid(cl_left):
		print("camera limits found!: ", cl_bottom.position.y, ", ", cl_top.position.y, ", ", cl_right.position.x, ", ", cl_left.position.x)
		camera.limit_bottom = cl_bottom.position.y
		camera.limit_top = cl_top.position.y
		camera.limit_right = cl_right.position.x
		camera.limit_left = cl_left.position.x
	else:
		print("camera limits NOT found! using default...")
		camera.limit_bottom = 10000000
		camera.limit_top = -10000000
		camera.limit_right = 10000000
		camera.limit_left = -10000000
	var musicobj = roomhandler.currentscene.get_node(str("musicsetter"))
	if is_instance_valid(musicobj):
		print("music setter found!: ", musicobj.target_song, ", ", musicobj.continue_after_last)
		music_controller.play(musicobj.target_song, musicobj.continue_after_last)
