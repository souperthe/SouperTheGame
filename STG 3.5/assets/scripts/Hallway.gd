extends Area2D


export (String) var targetdoor
export (String) var targetscene
var player
var playerin = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(_delta):
	#if playerin:
		#objplayer.position.x = self.position.x - (self.scale.x / 2)
		#objplayer.position.y = self.position.y - (self.scale.y / 2)
	pass


	
func enterscene():
	ct._fout()
	global.room_goto(targetscene, targetdoor)


func _on_Hallway_area_entered(_area):
	ct._fin()
	playerin = true
	yield(get_tree().create_timer(0.3), "timeout")
	enterscene()
