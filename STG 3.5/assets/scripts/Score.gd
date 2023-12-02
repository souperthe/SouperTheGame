extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func _process(_delta):
	$ranks.scale.x = lerp($ranks.scale.x, 1, 3 * _delta)
	$ranks.scale.y = lerp($ranks.scale.y, 1, 3 * _delta)
	$key.visible = objplayer.haskey
	$scoretext.text = (str(global.score))
	if global.rank == "1/5":
		$ranks.frame = 0
	if global.rank == "2/5":
		$ranks.frame = 1
	if global.rank == "3/5":
		$ranks.frame = 2
	if global.rank == "4/5":
		$ranks.frame = 3
	if global.rank == "5/5":
		$ranks.frame = 4
	if global.rank == "6/5":
		$ranks.frame = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ranks_frame_changed():
	$ranks.scale.x = 2
	$ranks.scale.y = 2
	
	pass # Replace with function body.
