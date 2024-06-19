extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (bool) var function
export (NodePath) var function_obj
onready var function_obj2:Node2D = get_node(function_obj)


# Called when the node enters the scene tree for the first time.
func _ready():
	if (global.othersroom.has(global.targetRoom2 + name)):
		queue_free()
	pass # Replace with function body.



func _process(delta):
	if not objplayer.haskey:
		$AnimatedSprite.modulate.a8 = 255
	if objplayer.haskey:
		$AnimatedSprite.modulate.a8 = 125
	pass


func createkeyfollow():
	var dashtrail = preload("res://assets/objects/floatingkey.tscn")
	var ghost: Node2D = dashtrail.instance()
	presobjs.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y

func _on_key_area_entered(area):
	if not objplayer.haskey:
		global.othersroom.append(global.targetRoom2 + name)
		global.resetcombo()
		objplayer.haskey = true
		queue_free()
		global.playsmall()
		createkeyfollow()
		if function:
			function_obj2.dothing()
		var rng = global.randi_range(1,3)
		if rng == 3:
			objplayer.voicepositive()
