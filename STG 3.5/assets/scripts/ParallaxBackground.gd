extends ParallaxBackground

func _process(delta):
	scroll_offset.x += 1000 * delta
