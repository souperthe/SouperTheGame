extends AudioStreamPlayer


var last_pitch = 1.0

func play(from_position=0.0):
	
	randomize()
	pitch_scale = rand_range(0.9, 1.1)
	
	while abs(pitch_scale - last_pitch) < .1:
		randomize()
		pitch_scale = rand_range(0.9, 1.1)
	
	last_pitch = pitch_scale
	
	.play(from_position)
