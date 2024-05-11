extends Control

var port = 31400
var ip
var nickname
var maxplayers = 10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var players = {}
var selfdata = { name = '', position = Vector2(5,5)}
# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	get_tree().connect('network_peer_connected', self, '_player_disconnected')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	ip = $address.text
	nickname = $username.text
#	pass

func create_server(player_nickname):
	selfdata.name = player_nickname
	selfdata[1] = selfdata
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(port, maxplayers)
	get_tree().set_network_peer(peer)
	


func _on_createlobby_pressed():
	create_server(nickname)
	pass # Replace with function body.
