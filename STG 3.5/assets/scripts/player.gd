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
var iscrouching = false
var temp = 0



#ar obj_player2= preload("res://assets/objects/player2.tscn")
var twop_active = false
var snap = 30
onready var tilt_tween = $Tween

onready var combo = $HUD/HUD/standard/Combo


#35

var snap_vector = Vector2.DOWN * snap


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
var last_floor_pos = Vector2()
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
var canuncrouch = true

var character = "souper"

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
onready var sfxspinng = $swooshing
onready var collide = $normal
onready var upthing = $thing
onready var darkeffect = $darkeffect
onready var sfxfire = $gunfire
onready var sfxkick = $upperkick
onready var sfxslide = $slide
onready var sfxsmsjump = $slide2
onready var cayatotime = $coyatotime
onready var iframestimer = $iframes
onready var uncrouchdetect = $detectcrouch
onready var sfxinstamach = $instamach4
onready var sfxslip = $slipping2
var penisman = false
var canpenis = true
var numdirection = 1
var walled = false


onready var playerthing = $playernotice



onready var attackbox = $attackch/attackcol
onready var machbox = $machch/machcol
onready var eattackbox = $enemych/attackcol
onready var ecattackbox = $enemych/crouchcol
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


func setbinds():
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
	
func _ready():
	if global.sisyphusbuild:
		speedrun = 550
	playercharacter = "S"
	gototargetdoor()
	setbinds()
	


func _physics_process(_delta):
	if is_on_floor():
		last_floor_pos = position
	$HUD.visible = global.settingshowhud
	if $animation.flip_h == false:
		$walled.scale.x = 1
	if $animation.flip_h == true:
		$walled.scale.x = -1
	#global.playsound(position, "res://assets/sound/sfx/sfx_bananapeel.wav")
	$mach3part.emitting = currentstate == "Mach3" and is_on_floor()
	$hurtbox/hurtblock.canhurt = currentstate == "Attack" or currentstate == "tumble"
	#$hurtbox/hurtblock/collide/CollisionShape2D.disabled = true
	if global.showcolloisions:
		$hurtbox/hurtblock.visible = currentstate == "Attack"
	if !global.showcolloisions:
		$hurtbox/hurtblock.visible = false
	if currentstate == "crouchsliding":
		sfxslide.volume_db = lerp(sfxslide.volume_db, 1, 0.5)
		if !sfxslide.playing:
			sfxslide.play()
	if !currentstate == "crouchsliding":
		#sfxslide.stop()
		sfxslide.volume_db = lerp(sfxslide.volume_db, -88, 0.1)
	#trail()
	if currentstate == "iceslip":
		if $slipping.playing == false:
			$slipping.play()
	if !currentstate == "iceslip":
		$slipping.stop()
		
	if $iframes.time_left == 0:
		canhurt = true
	if $iframes.time_left > 0:
		$AnimationPlayer.play("hurt")
		canhurt = false
	if !$iframes.time_left > 0:
		$AnimationPlayer.play("reset")
	currentstate = $StateMachine.statename
	_tilt()
	if currentstate == "bossdead":
		$PauseLayer/deadtext.visible = true
	if !currentstate == "bossdead":
		$PauseLayer/deadtext.visible = false
	animatonframes = $animation.get_frame()
	if is_instance_valid(presobjs.player2):
		playerthing.visible = true
	if !is_instance_valid(presobjs.player2):
		playerthing.visible = false
	if face:
		$machch.scale.x = -1
		$enemych.scale.x = -1
		$hurtbox.scale.x = -1
	if !face:
		$machch.scale.x = 1
		$enemych.scale.x = 1
		$hurtbox.scale.x = 1
	if playernumber == 0:
		if roomhandle.currentscene.name == "menu":
			$HUD/HUD.visible = false
			velocity.x = 0
			velocity.y = 0
		if !roomhandle.currentscene.name == "menu" and !roomhandle.currentscene.name == ("rankroom") and !roomhandle.currentscene.name == ("gameover"):
			$HUD/HUD.visible = true
		if roomhandle.currentscene.name == "rankroom":
			$HUD/HUD.visible = false
		if roomhandle.currentscene.name == "gameover":
			$HUD/HUD.visible = false
	iscrouching = currentstate == "crouch" or currentstate == "crouchair" or currentstate == "crouchsliding"
	if iscrouching:
		$normal.disabled = true
		$crouching.disabled = false
		$hurtblockdetect/standing.disabled = true
		$hurtblockdetect/crouching.disabled = false
	if !iscrouching:
		if currentstate == "Ladder":
			$normal.disabled = true
			$hurtblockdetect/standing.disabled = true
		if !currentstate == "Ladder":
			$normal.disabled = false
			$hurtblockdetect/standing.disabled = false
		$hurtblockdetect/crouching.disabled = true
		$crouching.disabled = true
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
		
func restartlevel():
	$PauseLayer/Pause.restartlevel()



func get_input_direction() -> float:
	#var direction = Input.get_action_strength(input_right) - Input.get_action_strength(input_left)
	var direction = int(Inputs.key_right) - int(Inputs.key_left)
	
	if direction < 0:
		animator.flip_h = true
		face = true
		numdirection = -1
	if direction > 0:
		animator.flip_h = false
		face = false
		numdirection = 1
		
	#OS.alert(str(direction), str(direction))
	return direction


func _on_ladderchecker_body_entered(_body):
	ladder = true


func _on_ladderchecker_body_exited(_body):
	ladder = false
	
func hurtplayer():
	if !currentstate == "bossdead":
		dohurt()

func numberthing(amount):
	var dashtrail = preload("res://assets/objects/smallnumber.tscn")
	var ghost: Node2D = dashtrail.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x + 50
	ghost.position.y = self.position.y
	ghost.number = str(amount)
	ghost.green = false
	
	
func dohurt():
	if canhurt:
		if global.bosslevel:
			if bosshealth == 1:
				hurtsfx.play()
				if !playernumber == 0:
					$StateMachine.transition_to("Nothing")
				if playernumber == 0:
					$StateMachine.transition_to("bossdead")
					doflash()
					global.cutscene = true
				bosshealth = 0
			if bosshealth > 1:
				hurteffect()
				hurtsfx.play()
				$StateMachine.transition_to("Hurt")
				doflash()
				bosshealth += -1
				canhurt = false
				$iframes.start()
		if !global.bosslevel:
			doflash()
			hurtsfx.play()
			if !global.score == 0 && !global.hardmode:
				global.score -= 100
				numberthing("-100")
			if !global.score == 0 && global.hardmode:
				global.score -= 100 * 5
				numberthing(str("-", 100 * 5))
			canhurt = false
			$iframes.start()
			hurteffect()
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
	animator.scale.x = defaultscale
	animator.scale.y = defaultscale
	respawn()


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





func _on_enemych_body_entered(body):
	#if !$iframes.time_left > 0:
	body.kill(velocity.x)
	attacksfx.stop()
	if body is Baddie:
		var thing = velocity.normalized()
		if global.hit_offset:
			if !body.state == body.states.stun:
				position.x -= thing.x * 35
		#hitwall.play()
	
func respawn():
	velocity.y = 0 
	modulate = Color(1, 1, 1, 1)
	velocity.x = 0 
	gototargetdoor()
	$StateMachine.transition_to("Idle")
	fpfallsfx.stop()
	mach3.stop()
	cutvoices()
	machbox.disabled = true
	emachbox.disabled = true
	attackbox.disabled = true
	eattackbox.disabled = true
	animator.scale.x = defaultscale
	animator.scale.y = defaultscale
	
	
func reset():
	ct._treset()
	ct._freset()
	$iframes.stop()
	modulate = Color(1, 1, 1, 1)
	velocity.y = 0 
	velocity.x = 0 
	gototargetdoor()
	$StateMachine.transition_to("Idle")
	fpfallsfx.stop()
	mach3.stop()
	global.lockcamera = false
	machbox.disabled = true
	emachbox.disabled = true
	attackbox.disabled = true
	eattackbox.disabled = true
	haskey = false
	bosshealth = 8
	animator.scale.x = defaultscale
	animator.scale.y = defaultscale
	gun = false
	global.combotimer.paused = false
	global.combotimer.stop()
	global.combodropped = false
	$fallzonetimer.stop()
	$HUD/HUD/fallen/AnimationPlayer.play("reset")
	$HUD/HUD/fallen.visible = false
	$HUD/HUD/fallen/Control/song.stop()
	$HUD/HUD/fallen/Control/song.volume_db = 6
	makethingnotvisible()
	cutvoices()
	global.treasure = false
	global.timedlevel = false
	global.oldtodmode = false
	global.moneybag = false
	global.greenkey = false
	global.panicdone = false
	global.combobreaks = 0
	global.countdown = true
	global.highestcombo = 0
	global.previouscombo = 0
	global.leveltime = 0
	global.rank = "1/5"
	global.infotext.rect_position.y = 560
	global.info("", 1)
	global.baddieroom = []
	global.collectablesroom = []
	global.othersroom = []
	global.escaperoom = []
	global.laps = 0
	global.score = 0
	global.combo = 0
	global.cutscene = false
	global.camerazoom = 1
	global.escapeexited = false
	global.cinematicbar = false
	music.musicvolume = 2
	music.temp = 0
	global.hidehud = false
	global.secretsfound = 0
	defaultdir()


func _on_machch_body_entered(body):
	body.destory()
	hitwall.play()
	#pass # Replace with function body.
	
func gototargetdoor():
	#position.x = -4050
	#position.y = -4050
	#$StateMachine.transition_to("Nothing")
	#yield(get_tree().create_timer(0.006), "timeout")
	#print("player sent to ", global.targetdoor)
	#$StateMachine.transition_to(oldstate)
	$HUD/HUD/standard.visible = true
	if global.bosslevel:
			$HUD/HUD/standard.visible = false
	if global.hidehud:
			$HUD/HUD/standard.visible = false
	#var nextroom:Node = roomhandle.currentscene
	if roomhandle.currentscene:
		if roomhandle.currentscene.get_node(global.targetdoor):
			position.x = roomhandle.currentscene.get_node(global.targetdoor).position.x
			position.y = roomhandle.currentscene.get_node(global.targetdoor).position.y - 15
		if !roomhandle.currentscene.get_node(global.targetdoor):
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
	#var thing = _body.position.x < position.x
	#animator.flip_h = thing
	#face = thing
	if !_body.forenemy:
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
	roomhandle.currentscene.add_child(ghost)
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
	roomhandle.currentscene.add_child(ghost)
	ghost.playsound = true
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y
	
func hurteffect():
	var whiteflash = preload("res://assets/objects/hurtpartical.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.amount = 500

	
func switchplayer(fasfasfdasfa):
	if fasfasfdasfa == "sockman":
		animator.frames = load("res://assets/important/sockmanframes.tres")
		playercharacter = "SM"
	if fasfasfdasfa == "souper":
		animator.frames = load("res://assets/important/souperframes.tres")
		playercharacter = "S"
func doflash():
	$AnimationPlayer2.play("doflash")
func _on_iframes_timeout():
	canhurt = true
	pass # Replace with function body.


func _on_detectcrouch_area_exited(_area):
	canuncrouch = true
	pass # Replace with function body.


func _on_detectcrouch_area_entered(_area):
	canuncrouch = false
	pass # Replace with function body.


func _on_detectcrouch_body_entered(body):
	if body is Collision:
		canuncrouch = false
	pass # Replace with function body.


func _on_detectcrouch_body_exited(body):
	if body is Collision:
		canuncrouch = true
	pass # Replace with function body.
func fall():
	if global.fall_cutscene:
		dofall()
	if !global.fall_cutscene:
		goofysound()
		respawn()
		global.camera.shake2(6, 0.5)
		$HUD/HUD/fallen/Control/ouch.play()
	
func dofall():
	temp = music.musicaudio.get_playback_position();
	music.musicaudio.playing = false
	cutscene()
	goofysound()
	$HUD/HUD/fallen.dothing()
	$HUD/HUD/fallen/Control/ouch.play()
	voicenegative()
	#global.makeflash()
	$HUD/HUD/fallen.visible = true
	global.combotimer.paused = true
	#music.musicvolume2 = 0
	if !global.panic:
		$HUD/HUD/fallen/Control/song.play()
	$HUD/HUD/fallen/Control/song.volume_db = 6
	$HUD/HUD/fallen/AnimationPlayer.play("reset")
	$fallzonetimer.start()
func portalffect():
	var whiteflash = preload("res://assets/objects/enemyportal.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y - 15
	
func _on_fallzone_timer_timeout():
	presobjs.player2respawn()
	respawn()
	position = Vector2(last_floor_pos.x, last_floor_pos.y)
	portalffect()
	global.combotimer.paused = false
	music.musicaudio.playing = true
	music.musicaudio.seek(temp)
	#music.musicvolume2 = 1
	$HUD/HUD/fallen/AnimationPlayer.play("fade")
	
	pass # Replace with function body.

func trail():
	if !$trailtimer.time_left > 0:
		$trailtimer.start()

func createtrail():
	var dashtrail = preload("res://assets/objects/playerdashtrail.tscn")
	var ghost: AnimatedSprite = dashtrail.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.playing = false
	ghost.flip_h = animator.flip_h
	ghost.global_position = global_position
	#ghost.position.y += -4.301
	ghost.frames = animator.frames
	ghost.animation = animator.animation
	ghost.frame = animator.frame
	ghost.rotation = animator.rotation
	ghost.scale.x = self.scale.x * animator.scale.x
	ghost.scale.y = self.scale.y * animator.scale.y
	#if playercharacter == "S":
		#ghost.modulate.r8 = 255
		#ghost.modulate.g8 = 0
		#ghost.modulate.b8 = 0
	#if playercharacter == "SM":
		#ghost.modulate.r8 = 224
		#ghost.modulate.g8 = 48
		#ghost.modulate.b8 = 0

func _on_trailtimer_timeout():
	createtrail()
	pass # Replace with function body.
	
func bangeffect():
	var whiteflash = preload("res://assets/objects/bangeffect.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position.x = self.position.x
	ghost.position.y = self.position.y - 15
	
func punchsound():
	var whiteflash = preload("res://assets/objects/punchsoumddelete.tscn")
	var ghost: Node2D = whiteflash.instance()
	roomhandle.currentscene.add_child(ghost)
	ghost.position = self.position
	ghost.dosound = true
	
func voicenegative():
	var rng = global.randi_range(1,3)
	match(rng):
		1:
			$n1.play()
			$n2.stop()
			$n3.stop()
		2:
			$n2.play()
			$n1.stop()
			$n3.stop()
		3:
			$n3.play()
			$n1.stop()
			$n2.stop()
			
func voicepositive():
	var rng = global.randi_range(1,3)
	match(rng):
		1:
			$p1.play()
			$p2.stop()
			$p3.stop()
		2:
			$p2.play()
			$p1.stop()
			$p3.stop()
		3:
			$p3.play()
			$p1.stop()
			$p2.stop()
			
func cutvoices():
	$p1.stop()
	$p2.stop()
	$p3.stop()
	$n1.stop()
	$n2.stop()
	$n3.stop()


func _on_walled_area_entered(_area):
	#walled = true
	pass # Replace with function body.


func _on_walled_area_exited(_area):
	#walled = false
	pass # Replace with function body.


func _on_walled_body_entered(body):
	if body is Collision:
		walled = true
	pass # Replace with function body.


func _on_walled_body_exited(body):
	if body is Collision:
		walled = false
	pass # Replace with function body.
