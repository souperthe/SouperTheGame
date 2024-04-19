extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$scoretext.bbcode_text = str("[center][wave]", global.score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time = global.leveltime
	var minutes := int(time / 60)
	var seconds := fmod(time, 60)
	var _milliseconds := fmod(time, 1) * 100
	var timet = (str("%01d:%02d" % [minutes, seconds]))
	if global.rank == "1/5":
		$Ranknew1.texture = load("res://assets/sprites/HUD/ranknew_1.png")
	if global.rank == "2/5":
		$Ranknew1.texture = load("res://assets/sprites/HUD/ranknew_2.png")
	if global.rank == "3/5":
		$Ranknew1.texture = load("res://assets/sprites/HUD/ranknew_3.png")
	if global.rank == "4/5":
		$Ranknew1.texture = load("res://assets/sprites/HUD/ranknew_4.png")
	if global.rank == "5/5":
		$Ranknew1.texture = load("res://assets/sprites/HUD/ranknew_5.png")
	if global.rank == "6/5":
		$Ranknew1.texture = load("res://assets/sprites/HUD/ranknew_6.png")
	if global.treasure:
		$Moneybag.modulate = Color8(255,255,255,255)
	if !global.treasure:
		$Moneybag.modulate = Color8(0,0,0,255)
	if global.moneybag:
		$Moneybag2.modulate = Color8(255,255,255,255)
	if !global.moneybag:
		$Moneybag2.modulate = Color8(0,0,0,255)
	$highestcombo.bbcode_text = str("[center]Highest Combo: ", global.highestcombo)
	$timespent.bbcode_text = str("[center]Time Spent: ", timet)
	$secret.bbcode_text = str("[center]Secrets Found: ", global.secretsfound)
	$combobreaks.bbcode_text = str("[center]Combo Breaks: ", global.combobreaks)
#	pass
