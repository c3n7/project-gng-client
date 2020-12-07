extends "res://levels/CodingLevels/Levels/HttpReqShared.gd"

export (GDScript) var coding_resources_object
export (Theme) var interactive_session_theme
export (Theme) var output_panel_theme

onready var coding_ground = $CanvasLayer/InteractiveSession/Full/Right/Top/CodingGround
onready var debug_output = $CanvasLayer/InteractiveSession/Full/Right/Bottom/TabContainer/Build/OutputMargin/Output
var coding_resources
onready var game_level = $GreenCoding01

var httpReqCode

func _ready():
	init($HTTPRequest)
	var error = connect("req_complete", self, "_on_req_complete")
	if error != OK:
		print_debug("Error while connecting to req_completed signal")
	coding_resources = coding_resources_object.new()
	coding_ground.text = coding_resources.code
	$CanvasLayer/InteractiveSession.set_theme(interactive_session_theme)
	debug_output.set_theme(output_panel_theme)
	$CanvasLayer/InteractiveSession/Alert.set_theme(output_panel_theme)


func _on_InteractiveSession_build():
	var code = _get_code_to_test()
	var test = coding_resources.tests
	var label = $CanvasLayer/InteractiveSession/Alert/HBoxContainer/Label
	var interactive_session = $CanvasLayer/InteractiveSession
	_test_code(code, test, label, interactive_session)


func _on_req_complete(build_status, result):
	debug_output.text = result
	debug_output.cursor_set_line(debug_output.get_line_count())
	$CanvasLayer/InteractiveSession.show_alert(build_status)
	_success(build_status)

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
		game_level.spawn_balloon('green', spawn_point, output)
