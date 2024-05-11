extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var anything = false
## KEYS
var input_attack = KEY_X
var input_jump = KEY_Z
var input_shoot = KEY_C
var input_dash = KEY_SHIFT
var input_pause = KEY_ESCAPE
var input_up = KEY_UP
var input_left = KEY_LEFT
var input_down = KEY_DOWN
var input_right = KEY_RIGHT
var input_enter = KEY_ENTER

var controller_attack = JOY_XBOX_A


## PLAYER 1
## directional
var key_up = false
var just_key_up = false
var key_right = false
var just_key_right = false
var key_down = false
var just_key_down = false
var key_left = false
var just_key_left = false
## extras
var key_jump = false
var just_key_jump = false
var key_dash = false
var just_key_dash = false
var key_attack = false
var just_key_attack = false
var key_shoot = false
var just_key_shoot = false
var key_pause = false
var just_key_pause = false
var key_enter = false
var just_key_enter = false


var cando = false
var justpressedtime = 0.5
var jpt = 0.5
var just_pressed
var a = false

var canpress_jump = true
var canpress_attack = true
var canpress_pause = true
var canpress_shoot = true
var canpress_dash = true
var canpress_enter = true


var canpress_right = true
var canpress_left = true
var canpress_up = true
var canpress_down = true

var gamepaused = false



# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	pass # Replace with function body.


func _oldprocess(_delta):
	canpress_jump = bool(justpressedtime > 0 and not justpressedtime < 0)
	if a:
		justpressedtime -= 1
	if !a:
		justpressedtime = 0.5
	if cando:
		cando = false
	pass
	
func _process(_elta):
	input()
	gamepaused = false
	
	if Input.is_key_pressed(input_jump) :
		canpress_jump = false
	elif not Input.is_key_pressed(input_jump):
		canpress_jump = true
		
	if Input.is_key_pressed(input_enter) :
		canpress_enter = false
	elif not Input.is_key_pressed(input_enter):
		canpress_enter = true
		
	if Input.is_key_pressed(input_attack):
		canpress_attack = false
	else:
		canpress_attack = true
		
	if Input.is_key_pressed(input_dash):
		canpress_dash = false
	elif not Input.is_key_pressed(input_dash):
		canpress_dash = true
		
	if Input.is_key_pressed(input_shoot) :
		canpress_shoot = false
	elif not Input.is_key_pressed(input_shoot):
		canpress_shoot = true
		
	if Input.is_key_pressed(input_pause):
		canpress_pause = false
	elif not Input.is_key_pressed(input_pause):
		canpress_pause = true
		
		
		
	if Input.is_key_pressed(input_up):
		canpress_up = false
	elif not Input.is_key_pressed(input_up):
		canpress_up = true
		
	if Input.is_key_pressed(input_down):
		canpress_down = false
	elif not Input.is_key_pressed(input_down):
		canpress_down = true
		
	if Input.is_key_pressed(input_left):
		canpress_left = false
	elif not Input.is_key_pressed(input_left):
		canpress_left = true
		
	if Input.is_key_pressed(input_right):
		canpress_right = false
	elif not Input.is_key_pressed(input_right):
		canpress_right = true
	
func input():
	# actions
	just_key_jump = Input.is_physical_key_pressed(input_jump) and canpress_jump
	canpress_jump = false
	key_jump = Input.is_physical_key_pressed(input_jump)
	just_key_attack = Input.is_physical_key_pressed(input_attack) and canpress_attack
	key_attack = Input.is_physical_key_pressed(input_attack)
	just_key_dash = Input.is_physical_key_pressed(input_dash) and canpress_dash
	key_dash = Input.is_physical_key_pressed(input_dash)
	just_key_shoot = Input.is_physical_key_pressed(input_shoot) and canpress_shoot
	key_shoot = Input.is_physical_key_pressed(input_shoot)
	just_key_pause = Input.is_physical_key_pressed(input_pause) and canpress_pause
	key_pause = Input.is_physical_key_pressed(input_pause)
	just_key_enter = Input.is_physical_key_pressed(input_enter) and canpress_enter
	key_enter = Input.is_physical_key_pressed(input_enter)
	# directional
	just_key_up = Input.is_physical_key_pressed(input_up) and canpress_up
	key_up = Input.is_physical_key_pressed(input_up)
	just_key_right = Input.is_physical_key_pressed(input_right) and canpress_right
	key_right = Input.is_physical_key_pressed(input_right)
	just_key_left = Input.is_physical_key_pressed(input_left) and canpress_left
	key_left = Input.is_physical_key_pressed(input_left)
	just_key_down = Input.is_physical_key_pressed(input_down) and canpress_down
	key_down = Input.is_physical_key_pressed(input_down)
	
func _oldinput(event):
	#var just_pressed = event and event.is_pressed() and cando #and not event.is_echo()
	#var just_pressed = event is InputEventKey and event.pressed and not event.is_echo()
	just_pressed = justpressedtime < -1.5 and event is InputEventKey and not event.is_echo()
	if event is InputEventKey and event.is_pressed() and not a:
		#justpressedtime = 0.5
		#canpress = false
		a = true
	elif event is InputEventKey and !event.is_pressed() and a:
		a = false
	#just_pressed = justpressedtime < 0
	##justpressedtime = 0.5
	#if just_pressed:
		#cando = true
	#if not event.is_echo():
		#cando = true
	# extras
#func _input(event):
	#if event is InputEventKey:
		#if event.pressed and event.keycode == KEY_T:
			#get_tree().quit()
