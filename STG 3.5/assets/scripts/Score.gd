extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var a = 1
var oldmumber = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	$ranks.scale.x = 1
	$ranks.scale.y = 1
	pass # Replace with function body.
	
	
func _process(_delta):
	$ranks.scale.x = lerp($ranks.scale.x, 1, 3 * _delta)
	$ranks.scale.y = lerp($ranks.scale.y, 1, 3 * _delta)
	$key.visible = objplayer.haskey
	$greenkey.visible = global.greenkey
	$scoretext.text = (str(global.score))
	if global.rank == "1/5":
		$ranks.frame = 0
		a = 1
		#$ranks.frame = 0
	if global.rank == "2/5":
		$ranks.frame = 1
		a = 2
		#$ranks.frame = 1
	if global.rank == "3/5":
		$ranks.frame = 2
		a = 3
		#$ranks.frame = 2
	if global.rank == "4/5":
		$ranks.frame = 3
		a = 4
		#$ranks.frame = 3
	if global.rank == "5/5":
		$ranks.frame = 4
		a = 5
		#$ranks.frame = 4
	if global.rank == "6/5":
		$ranks.frame = 5
		a = 6
		#$ranks.frame = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ranks_frame_changed():
	oldmumber = a
	$AnimationPlayer.play("rankchanged")
	if a > oldmumber:
		$up.play()
	if a < oldmumber:
		$down.play()
	
	pass # Replace with function body.
