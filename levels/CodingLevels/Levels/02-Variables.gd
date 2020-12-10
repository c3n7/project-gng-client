extends "res://levels/CodingLevels/Levels/HttpReqShared.gd"

func _get_nodes():
	coding_ground = $CanvasLayer/InteractiveSession/Full/Right/Top/CodingGround
	debug_output = $CanvasLayer/InteractiveSession/Full/Right/Bottom/TabContainer/Build/OutputMargin/Output
	slides = $CanvasLayer/InteractiveSession/Full/Right/Bottom/TabContainer/Slides/SlidesMargin/Slide
	slideCountLabel =$CanvasLayer/InteractiveSession/Full/Right/Bottom/TabContainer/Slides/Count/CountLabel
	exercises = $CanvasLayer/InteractiveSession/Full/Right/Bottom/TabContainer/Exercise/ExerciseMargin/Exercise
	interactive_session = $CanvasLayer/InteractiveSession
	alert = $CanvasLayer/InteractiveSession/Alert
	httpreq = $HTTPRequest
	
	pause_screen = $GreenCoding01/CanvasLayer/paused_dialog
	game_level = $GreenCoding01


func _on_InteractiveSession_build():
	var code = _get_code_to_test()
	var test = coding_resources.tests
	var label = $CanvasLayer/InteractiveSession/Alert/HBoxContainer/Label
	_test_code(code, test, label)


func _get_code_to_test():
	var pre = "def printer():"
	var body = ""
	for i in range(coding_ground.get_line_count()):
		body += "    " + coding_ground.get_line(i) + "\n"
	var post = ""
	return pre + "\n" + body + "\n" + post


func _success(build_status):
	if build_status == "success":
		var player = game_level.get_node("Player").get_child(0)
		var spawn_point = Vector2(player.position.x, rand_range(-100, -300))
		var output = "john doe 1997 " + str(OS.get_date()["year"] - 1997)
		game_level.spawn_balloon('green', spawn_point, output, true)
