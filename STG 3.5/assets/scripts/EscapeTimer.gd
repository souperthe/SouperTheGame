extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var idk = false
var penis = false
var shakeamount = 1
onready var rand = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("reset")
	
	
	


func _process(_delta):
	var time = global.fill.get_time_left()
	var minutes := int(time / 60)
	var seconds := fmod(time, 60)
	var _milliseconds := fmod(time, 1) * 100
	var timet = (str("%01d:%02d" % [minutes, seconds]))
	if global.panic:
		randomize()
		$holder/shakey.rect_position = Vector2(
			rand.randi_range(-shakeamount, shakeamount),
			rand.randi_range(-shakeamount, shakeamount)	
			)
	$holder/shakey/laps.text = str("LAP ", global.laps + 1)
	if !global.panic:
		$holder/shakey/laps.rect_position.y = -23.8
	if global.panic and !global.laps == 0:
		$holder/shakey/laps.rect_position.y = lerp($holder/shakey/laps.rect_position.y , 16.2, 1.3 * _delta)
	if time >= 60:
		$holder/shakey/time.modulate.g8 = 255
		$holder/shakey/time.modulate.b8 = 255
	if time <= 60:
		$holder/shakey/red.play("panic")
	if !global.panicdone:
		$holder/shakey/progress.max_value = global.fill.wait_time
		$holder/shakey/progress.value = global.fill.get_time_left()
		$holder/shakey/time.text = timet
		$holder/shakey/time2.bbcode_text = str("[center][shake rate=50.0 level=9 connected=0]", timet, "[/shake][/center]")
	if global.panicdone:
		global.camerarotamount = lerp(global.camerarotamount, 6, 0.2 * _delta)
		if !penis:
			global.room_goto("res://assets/scenes/gameover.tscn", "door1")
			penis = true
	if global.panic == true and not idk:
		global.panicdone = false
		global.fill.paused = false
		music.playescape()
		global.camerarotamount = 2.5
		global.panicdone = false
		if global.hardmode:
			global.fill.wait_time = global.fill.wait_time / 2
		global.fill.start()
		$AnimationPlayer.play("escapestart")
		penis = false
		idk = true
	if global.panic == false:
		global.fill.stop()
		$AnimationPlayer.play("reset")
		idk = false
		
