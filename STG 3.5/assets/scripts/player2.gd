extends Player

func _ready():
	playernumber = 1
	setbinds()
	$playernotice.texture = load("res://assets/sprites/player_souper/player2.png")
	$playermach.modulate.r8 = 0
	$playermach.modulate.g8 = 0
	$playermach.modulate.b8 = 255
	$PauseLayer/Pause.enabled = false
	self.name = "Player2"
	
