extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var alreadykilled = false


# Called when the node enters the scene tree for the first time.
func _ready():
	global.bosslevel = 1
	global.restartlevel = "res://assets/scenes/boss_test.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
