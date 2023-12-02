class_name Player
extends KinematicBody2D

export (int) var playernumber
export (String) var playercharacter
export (NodePath) var _animation_player
onready var animation_player:AnimatedSprite = get_node(_animation_player)

const FLOOR_NORMAL = Vector2.DOWN
const SNAP_DIRECTION = Vector2.DOWN
const SNAP_LENGTH = 64.0
const SLOPE_LIMIT = 0

var defaultscale = 0.56

var haskey = false
var gun = false



#ar obj_player2= preload("res://assets/objects/player2.tscn")
var twop_active = false
var snap = 30
onready var tilt_tween = $Tween

onready var combo = $HUD/HUD/standard/Combo


#35

var snap_vector = Vector2.DOWN * snap if not Input.is_action_just_pressed("jump") else Vector2.ZERO


var speed = 450
var speedrun = 1050
var speedrun2 = 2050
var speedrun3 = 2050
var landing : bool
var hurt : bool
var form : bool
var ladder := false
var jump_impulse = 670
var attack_impulse = 335
var gravity = 1600
var acceleration = 40
var friction = 60 #60
var air_friction = 10
var state_machine = null
var face : bool
var canhurt = true
var disabletitlt = false
var bosshealth = 8
var currentstate 

var velocity := Vector2.DOWN

onready var state = $StateMachine

onready var sprite = $animation
onready var raycast = $RayCast2D
onready var formenter = $formenter
onready var formexit = $formexit
onready var step = $step
onready var jumpsfx = $jump
onready var coyato = $dashtimer
onready var turntimer = $turntimer
onready var mach3 = $mach3
onready var mach4 = $mach4
onready var machprep = $machprep
onready var change = $machready
onready var hurtsfx = $hurt
onready var hitwall = $hitwall
onready var hitceiling = $hitceiling
onready var machcancel = $machcancel
onready var animplayer = $AnimationPlayer
onready var animatonframes = 0
onready var cango = 0
onready var candoor = 0
onready var hurttimer = $hurtimer
onready var animator = $animation
onready var attacksfx = $swing
onready var sjumpreleasesfx = $s_release
onready var sjumpentersfx = $s_enter
onready var fpfallsfx = $fp_fall
onready var sfxbump = $bumpwall
onready var sfxfunny = $funny
onready var animation2 = $AnimationPlayer
onready var speedpart = $runpart
onready var speed3part = $mach3part
onready var asspart = $asspart
onready var sfxgrapple = $grapple
onready var sfxburn = $burn
onready var sfxfoot = $realste
onready var sfxburnscream = $burnscream
onready var sfxbreak = $brake
onready var sfxspinng = $swooshing
onready var collide = $CollisionShape2D2
onready var upthing = $thing
onready var darkeffect = $darkeffect
onready var sfxfire = $gunfire
onready var cayatotime = $coyatotime
var penisman = false
var canpenis = true


onready var playerthing = $playernotice



onready var attackbox = $attackch/attackcol
onready var machbox = $machch/machcol
onready var eattackbox = $enemych/attackcol
onready var emachbox = $enemych/machcol
onready var pmachbox = $playermach/playermachcol
onready var mattackbox = $enemych/middleattack
onready var mmachbox = $machch/middlemachcol

#controls

onready var input_up = "move_up"
onready var input_down = "move_down"
onready var input_left = "move_left"
onready var input_right = "move_right"
onready var input_jump = "jump"
onready var input_attack = "attack"
onready var input_run = "run"
onready var input_noclip = "noclip"
onready var input_shoot = "shoot"
#-------------------------



func _ready():
	if global.sisyphusbuild:
		speedrun = 550
	playercharacter = "S"
	gototargetdoor()
	if playernumber == 0:
		input_up = "move_up"
		input_down = "move_down"
		input_left = "move_left"
		input_right = "move_right"
		input_jump = "jump"
		input_attack = "attack"
		input_run = "run"
		input_noclip = "noclip"
	if playernumber == 1:
		input_up = "2move_up"
		input_down = "2move_down"
		input_left = "2move_left"
		input_right = "2move_right"
		input_jump = "2jump"
		input_attack = "2attack"
		input_run = "2run"
		input_noclip = "2noclip"
	


func _physics_process(_delta):
	#trail()
	if Input.is_action_just_pressed("penis"):
		if canpenis:
			formenter.play()
			penisman = !penisman
			penismanswitcher()
	currentstate = $StateMachine.statename
	_tilt()
	animatonframes = $animation.get_frame()
	if is_instance_valid(presobjs.player2):
		playerthing.visible = true
	if !is_instance_valid(presobjs.player2):
		playerthing.visible = false
	if playernumber == 0:
		if get_tree().current_scene.name == "menu":
			$HUD/HUD.visible = false
			velocity.x = 0
			velocity.y = 0
		if !get_tree().current_scene.name == "menu" and !get_tree().current_scene.name == "rankroom":
			$HUD/HUD.visible = true
		if global.bosslevel:
			$HUD/HUD/standard.visible = false
		if !global.bosslevel:
			$HUD/HUD/standard.visible = true
		if get_tree().current_scene.name == "rankroom":
			$HUD/HUD.visible = false
	#print(animatonframes)
	#f Input.is_action_pressed("2jump") and !twop_active:
		#wop_active = true
		
		
	
func _tilt():
	if is_on_floor() and raycast.is_colliding() and not disabletitlt:
		var normal = raycast.get_collision_normal()
		#animator.rotation = normal.angle() + deg2rad(90)
		animator.rotation = lerp(animator.rotation, normal.angle() + deg2rad(90), 0.3)
		#self.rotation = normal.angle() + deg2rad(90)
	else:
		animator.rotation = 0
		#self.rotation = 0



func get_input_direction() -> float:
	var direction = Input.get_action_strength(input_right) - Input.get_action_strength(input_left)
	
	if direction < 0:
		animator.flip_h = true
		$machch.scale.x = -1
		$enemych.scale.x = -1
		face = true
	if direction > 0:
		$machch.scale.x = 1
		$enemych.scale.x = 1
		animator.flip_h = false
		face = false
		
	
	return direction


func _on_ladderchecker_body_entered(_body):
	ladder = true


func _on_ladderchecker_body_exited(_body):
	ladder = false
	
func hurtplayer():
	if canhurt:
		if global.bosslevel:
			if bosshealth == 1:
				if !playernumber == 0:
					$StateMachine.transition_to("Nothing")
				if playernumber == 0:
					$StateMachine.transition_to("bossdead")
					global.cutscene = true
				bosshealth = 0
			if bosshealth > 1:
				$StateMachine.transition_to("Hurt")
				bosshealth += -1
		if !global.bosslevel:
			if !global.score == 0:
				global.score -= 5
			$StateMachine.transition_to("Hurt")
		
		
func banana():
	$StateMachine.transition_to("peelslip")
	
func idle():
	$StateMachine.transition_to("Idle")
	
func snow():
	$StateMachine.transition_to("snowman_idle")

func enterdoor():
	$StateMachine.transition_to("EnterDoor")
	
func exitdoor():
	$StateMachine.transition_to("ExitDoor")
	
func cutscene():
	$StateMachine.transition_to("Nothing")
	
func win():
	$StateMachine.transition_to("congrat")
	
func exitlapportal():
	$StateMachine.transition_to("fallpound_fall")


func hardtumble():
	$StateMachine.transition_to("rollthing")
	
func changestate(setstate):
	$StateMachine.transition_to(setstate)
	
	
func hitpartical():
	$hitpart1.emitting = true
	$hitpart2.emitting = true
	$hitpart3.emitting = true
	
func poundpart():
	$poundpart.emitting = true
	
func trail():
	var dashtrail = preload("res://assets/objects/playerdashtrail.tscn")
	var ghost: AnimatedSprite = dashtrail.instance()
	get_parent().add_child(ghost)
	ghost.playing = false
	ghost.flip_h = animator.flip_h
	ghost.global_position = global_position
	#ghost.position.y += -4.301
	ghost.frames = animator.frames
	ghost.animation = animator.animation
	ghost.frame = animator.frame
	ghost.rotation = animator.rotation
	ghost.scale.x = animator.scale.x
	ghost.scale.y = animator.scale.y





func _on_enemych_body_entered(body):
	body.kill(velocity.x)
	attacksfx.stop()
	
func respawn():
	velocity.y = 0 
	velocity.x = 0 
	gototargetdoor()
	$StateMachine.transition_to("Idle")
	fpfallsfx.stop()
	mach3.stop()
	machbox.disabled = true
	emachbox.disabled = true
	attackbox.disabled = true
	eattackbox.disabled = true
	
	
func reset():
	velocity.y = 0 
	velocity.x = 0 
	gototargetdoor()
	$StateMachine.transition_to("Idle")
	fpfallsfx.stop()
	mach3.stop()
	machbox.disabled = true
	emachbox.disabled = true
	attackbox.disabled = true
	eattackbox.disabled = true
	haskey = false
	bosshealth = 8
	gun = false
	global.treasure = false
	global.panicdone = false
	global.rank = "1/5"
	global.baddieroom = []
	global.collectablesroom = []
	global.othersroom = []
	global.escaperoom = []
	global.laps = 0
	global.score = 0
	global.combo = 0
	global.cutscene = false
	global.camerazoom = 1
	defaultdir()


func _on_machch_body_entered(body):
	body.destory()
	hitwall.play()
	#pass # Replace with function body.
	
func gototargetdoor():
	position.x = -4050
	position.y = -4050
	#$StateMachine.transition_to("Nothing")
	yield(get_tree().create_timer(0.006), "timeout")
	#print("player sent to ", global.targetdoor)
	#$StateMachine.transition_to(oldstate)
	if get_tree().get_current_scene().get_node(global.targetdoor):
		position.x = get_tree().get_current_scene().get_node(global.targetdoor).position.x
		position.y = get_tree().get_current_scene().get_node(global.targetdoor).position.y - 15
	if !get_tree().get_current_scene().get_node(global.targetdoor):
		position.x = position.x
		position.y = position.x
		
		
func gooffscreen():
	position.x = -2720
	position.y = -2720
	
func defaultdir():
	animator.flip_h = false
	face = false
	
func makethingvisible():
	$thing.visible = true
	
func makethingnotvisible():
	$thing.visible = false
	




func _on_hurtblockdetect_body_entered(_body):
	hurtplayer()
	
	
func scaryname():
	var waittime = 0.05
	OS.set_window_title("Souper The Game")
	yield(get_tree().create_timer(waittime), "timeout")
	OS.set_window_title("$ouper The Game")
	yield(get_tree().create_timer(waittime), "timeout")
	OS.set_window_title("S0uper The Game")
	yield(get_tree().create_timer(waittime), "timeout")
	OS.set_window_title("So^per The Game")
	yield(get_tree().create_timer(waittime), "timeout")
	OS.set_window_title("Souder The Game")
	yield(get_tree().create_timer(waittime), "timeout")
	OS.set_window_title("Soup3r The Game")
	yield(get_tree().create_timer(waittime), "timeout")
	OS.set_window_title("Souper Ihe Game")
	yield(get_tree().create_timer(waittime), "timeout")
	OS.set_window_title("Souper T4e Game")
	yield(get_tree().create_timer(waittime), "timeout")
	OS.set_window_title("Souper Th3 Game")
	yield(get_tree().create_timer(waittime), "timeout")
	OS.set_window_title("Souper The 6ame")
	yield(get_tree().create_timer(waittime), "timeout")
	OS.set_window_title("Souper The G@me")
	yield(get_tree().create_timer(waittime), "timeout")
	OS.set_window_title("Souper The Gawe")
	yield(get_tree().create_timer(waittime), "timeout")
	OS.set_window_title("Souper The Gam3")
	yield(get_tree().create_timer(waittime), "timeout")
	scaryname()


func _on_lavacheck_body_entered(_body):
	if !currentstate == ("bossdead"):
		$StateMachine.transition_to("assburned")
	pass # Replace with function body.
	
func penismanswitcher():
	if penisman:
			animator.frames = load("res://assets/tres_files/legacysouper_anims.tres")
			animator.scale.x = 0.255
			animator.scale.y = 0.255
			animator.position.y = 0
			defaultscale = 0.8
	if not penisman:
			animator.frames = load("res://assets/tres_files/REALsouoperanimations.tres")
			animator.scale.x = 0.56
			animator.scale.y = 0.56
			animator.position.y = -0
			defaultscale = 0.56
			
func deadgun():
	var whiteflash = preload("res://assets/objects/deadthing.tscn")
	var ghost: KinematicBody2D = whiteflash.instance()
	get_tree().get_current_scene().add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	ghost.velocity.y = -900
	ghost.velocity.x = 0
	ghost.spinamount = 2
	ghost.sprite.texture = load("res://assets/sprites/player_souper/gun.png")
	ghost.sprite.scale.x = 0.56
	ghost.sprite.scale.y = 0.56

func goofysound():
	var whiteflash = preload("res://assets/objects/sillysfx3d.tscn")
	var ghost: Node2D = whiteflash.instance()
	get_tree().get_current_scene().add_child(ghost)
	ghost.playsound = true
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y

	
