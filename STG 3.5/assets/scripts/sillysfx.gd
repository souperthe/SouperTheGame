extends Node2D


var rang = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playsound = false
var random


# Called when the node enters the scene tree for the first time.
func _ready():
	var t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	queue_free()
	pass # Replace with function body.
	

func _process(_delta):
	rang.randomize()
	var my_random_number2 = rang.randi_range(1, 13)
	random = my_random_number2
	if playsound == true:
		sound()
		playsound = false
	
func sound():
	#var my_random_number2 = rang.randi_range(1, 2)
	#print(my_random_number2)
	if random == 13:
		$j.play()
	if random == 12:
		$n.play()
	if random == 11:
		$k.play()
	if random == 10:
		$j.play()
	if random == 9:
		$i.play()
	if random == 8:
		$h.play()
	if random == 7:
		$g.play()
	if random == 6:
		$f.play()
	if random == 5:
		$e.play()
	if random == 4:
		$d.play()
	if random == 3:
		$c.play()
	if random == 2:
		$b.play()
	if random == 1:
		$a.play()
	pass
