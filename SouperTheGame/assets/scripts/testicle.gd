extends Baddie



func _ready():
	deadsprite = "res://assets/images/otheranimated/testicle/testicle_0003.png"
	directipn = global.choose_randomly([1,-1])
	if global.baddieroom.has(global.targetscene + name):
		queue_free()
		print(name, " removed", ", in: ", global.targetscene.get_file())


func process(delta):
	match(state):
		states.normal:
			if !is_on_floor():
				vsp += grv
				#if is_on_floor():
			if is_on_floor():
				global.oneshot_sfx("res://assets/sounds/steprandomizedtres.tres", position, -12)
				global.createobject("res://assets/objects/landdust.tscn", Vector2(position.x, position.y - 22))
				vsp = -8
				global.oneshot_sfx("res://assets/sounds/sfx/sfx_boing.wav", position, -12)
			hsp = directipn * 3
			turn()
		states.stun:
			vsp += grv
			animator.play("stun")
			if is_on_floor():
				stunstime -= 65 * delta
				hsp = global.approach(hsp, 0, 35 * delta)
			if is_on_wall():
				hsp = -hsp
			if stunstime < 0:
				state = states.normal
				animator.play("default")
				hsp = 0
	$baddiestuff.scale.x = directipn
	match(directipn):
		1:
			animator.flip_h = false
		-1:
			animator.flip_h = true
	velocity.x = (hsp * 4000) * delta
	velocity.y = (vsp * 4000) * delta
	getspriteangle(delta)
	move_and_slide()
