extends Node

func _process(_delta):
	update_activity()


func update_activity() -> void:
	var activity = Discord.Activity.new()
	activity.set_type(Discord.ActivityType.Playing)
	if get_tree().current_scene.name == "menu":
		activity.set_details("In the Menus")
	if !get_tree().current_scene.name == "menu":
		if global.hardmode:
			activity.set_details("In a level with Tod mode.")
		if !global.hardmode:
			activity.set_details("In a level with standard.")
	if get_tree().current_scene.name == "menu":
		activity.set_state("The most epic game of all time..")
	if !get_tree().current_scene.name == "menu":
		if global.hidehud:
			activity.set_state("The most epic game of all time..")
		if !global.hidehud:
			if global.bosslevel:
				activity.set_state(str("Health: ", objplayer.bosshealth))
			if !global.bosslevel:
				activity.set_state(str("Rank: ", global.rank, ",", "  Score: ", global.score, ", ", "Combo: ", global.combo))

	var assets = activity.get_assets()
	assets.set_large_image("big")
	assets.set_large_text("Souper The Game")
	assets.set_small_image("soupercon")
	assets.set_small_text(str("Playing as ", "Souper"))
	
	var _timestamps = activity.get_timestamps()
	#timestamps.set_start(OS.get_unix_time() + 100)
	#timestamps.set_end(OS.get_unix_time() + 500)

	var result = yield(Discord.activity_manager.update_activity(activity), "result").result
	if result != Discord.Result.Ok:
		push_error(str(result))
