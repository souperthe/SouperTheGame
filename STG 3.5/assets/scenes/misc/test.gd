extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	self.scale = lerp(self.scale, Vector2(1,1),0.1)
	if $Area2D.overlaps_body(objplayer):
		self.scale = Vector2(1.2, 1.2)
		$AudioStreamPlayer2D.play()
		creategu2()
	pass


func createguy():
	var enemy1 = preload("res://assets/objects/enemys/testicle.tscn")
	var enemy2 = preload("res://assets/objects/banana.tscn")
	var enemy3 = preload("res://assets/objects/enemys/forkdevil.tscn")
	var enemy4 = preload("res://assets/objects/key.tscn")
	var enemy5 = preload("res://assets/objects/guncollect.tscn")
	var enemy6 = preload("res://assets/objects/evilguy.tscn")
	var enemy7 = preload("res://assets/objects/bosstext.tscn")
	var array = [enemy1,enemy2,enemy3,enemy4,enemy5,enemy6,enemy7]
	var nth = array.size()
	var dashtrail = array
	var ghost: KinematicBody2D = dashtrail.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = position
	
func creategu2():
	var enemy1 = preload("res://assets/objects/enemys/testicle.tscn")
	var enemy2 = preload("res://assets/objects/banana.tscn")
	var enemy3 = preload("res://assets/objects/enemys/forkdevil.tscn")
	var enemy4 = preload("res://assets/objects/enemys/dummy.tscn")
	var enemy5 = preload("res://assets/objects/guncollect.tscn")
	var enemy6 = preload("res://assets/objects/evilguy.tscn")
	var enemy7 = preload("res://assets/objects/bosstext.tscn")
	var array = [enemy1,enemy3]
	var nth = array.size()
	var albert_simmons = array[randi() % nth]
	if nth > 0:
		nth -= 1
	var spawn = albert_simmons.instance()
	roomhandle.currentscene.call_deferred("add_child", spawn)
	spawn.position = self.position

