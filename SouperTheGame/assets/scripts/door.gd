extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = self.name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Position.visible = global.showdebug
	$Label.visible = global.showdebug
	pass
