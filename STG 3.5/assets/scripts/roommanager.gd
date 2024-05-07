extends Node

export var scene: PackedScene
var currentscene:Node
var m = 1
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#scenegoto("res://assets/scenes/tutorial/tutorial_1.tscn")
	pass # Replace with function body.
	
static func queue_free_children(node: Node) -> void:
	for idx in node.get_child_count():
		node.queue_free()
		
static func free_children(node: Node) -> void:
	for idx in node.get_child_count():
		node.free()
		
func _process(delta):
	currentscene = currentscene


func scenegoto(selectedscene):
	scene = load(selectedscene)
	var spawnedscene = scene.instance()
	currentscene = spawnedscene
	if self.get_child_count() > 0:
		var children = self.get_children()
		for c in children:
			self.remove_child(c)
			c.queue_free()
		add_child(spawnedscene)
		var my_random_number = rng.randi_range(0.0, 1.0)
		rng.randomize()
		if global.oldtodmode:
			m = currentscene.scale.x
			#if my_random_number == 1:
				#objplayer.scale.x = -1
				#currentscene.rotation_degrees = 90
			#if my_random_number == 0:
				#currentscene.modulate = Color8(0,0,0,255)
		if music.playmusic:
			music.domusic()
	else:
		add_child(spawnedscene)
		if music.playmusic:
			music.domusic()
		
		
	#queue_free_children(self)
	#free_children(self)
	#add_child(scene)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
