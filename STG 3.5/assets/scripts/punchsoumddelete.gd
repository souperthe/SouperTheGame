extends Node2D

var rang = RandomNumberGenerator.new()
var random
var dosound = false
var a = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func adosound():
	if random == 6:
		$hurt6.play()
	if random == 5:
		$hurt5.play()
	if random == 4:
		$hurt4.play()
	if random == 3:
		$hurt3.play()
	if random == 2:
		$hurt2.play()
	if random == 1:
		$hurt1.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rang.randomize()
	var my_random_number2 = rang.randi_range(1, 6)
	randomize()
	random = my_random_number2
	if dosound:
		if !a:
			adosound()
			a = true
#	pass
