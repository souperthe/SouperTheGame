extends Node2D


export (NodePath) var _boss
onready var boss:KinematicBody2D = get_node(_boss)
var fightdone = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	startboss()
	$CanvasLayer/boss.rect_position.y = 0
	pass # Replace with function body.


func _process(delta):
	if is_instance_valid(boss):
		$CanvasLayer/boss/boss/bosshealth.text = str(boss.bosshealth)
	if objplayer.bosshealth == 0:
		$CanvasLayer/boss.rect_position.y = lerp($CanvasLayer/boss.rect_position.y, -544, 0.5 * delta)
	if !is_instance_valid(boss):
		$CanvasLayer/boss.rect_position.y = lerp($CanvasLayer/boss.rect_position.y, -544, 0.5 * delta)
		if not fightdone:
			fightdone()
	pass
	
func startboss():
	var t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	boss.canfight = true
	
func fightdone():
	objplayer.cutscene()
	objplayer.animator.play("awesome")
	music.stopmusic()
	global.makeflash()
	$impact.play()
	fightdone = true
	
