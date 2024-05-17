extends Node2D

onready var player2 = get_node("/root/presobjs/Player2")
onready var tod = get_node("/root/presobjs/evilguy")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func player2gototargetdoor():
	if player2:
		get_node("Player2").gototargetdoor()
		
		
func player2respawn():
	if player2:
		get_node("Player2").respawn()
	

# Called when the node enters the scene tree for the first time.

	
	
func createtod():
	var whiteflash = preload("res://assets/objects/evilguy.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	add_child(ghost)
	
func killtod():
	if tod:
		tod.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), global.musicvolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), global.sfxvolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), global.mastervolume)
#	pass
