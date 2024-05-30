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
		
#func _process(_delta):
	#currentscene = currentscene


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
		#if currentscene.name != "menu":
		#	currentscene.scale = Vector2(2,2)
		if music.playmusic:
			music.domusic()
		global.roomstart()
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
