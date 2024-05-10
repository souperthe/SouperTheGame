extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var anchorY = 0
var frequency = 0.1
var amplitude = 20
var timer = 0
var timer2 = 0

export (bool) var green


# Called when the node enters the scene tree for the first time.
func _ready():
	position = objplayer.position
	pass # Replace with function body.


func createdead1(green):
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.velocity.y = -800
	ghost.velocity.x = rand_range(-500,500)
	ghost.spinamount = rand_range(-200,200)
	#ghost.spinamount = 0
	ghost.sprite.rotation_degrees = rand_range(-360,360)
	randomize()
	if green:
		ghost.sprite.modulate.r8 = 0
		ghost.sprite.modulate.b8 = 0
	ghost.sprite.texture = load("res://assets/sprites/animated/key/key_0001.png")
	ghost.sprite.scale.x = 0.56
	ghost.sprite.scale.y = 0.56
	ghost.partical = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !green:
		if !objplayer.haskey:
			queue_free()
			createdead1(false)
	if green:
		$sprite.modulate.r8 = 0
		$sprite.modulate.b8 = 0
		if !global.greenkey:
			queue_free()
			createdead1(true)
	position = lerp(position, objplayer.position, 5 * delta)
	$sprite.position.y = anchorY + sin(timer2*frequency)*amplitude
	$sprite.position.x = anchorY + sin(timer*frequency)*50
	timer += 0.5
	timer2 += 0.2
#	pass
