extends "res://levels/CodingLevels/Levels/HttpReqShared.gd"

export (GDScript) var coding_resources_object

onready var coding_ground = $CanvasLayer/InteractiveSession/Full/Right/Top/CodingGround
onready var debug_output = $CanvasLayer/InteractiveSession/Full/Right/Bottom/TabContainer/Build/OutputMargin/Output
var coding_resources
var httpReqCode

func _ready():
	init($HTTPRequest)
	var error = connect("req_complete", self, "_on_req_completed")
	if error != OK:
		print_debug("Error while connecting to req_completed signal")
	coding_resources = coding_resources_object.new()
	coding_ground.text = coding_resources.code


func _on_InteractiveSession_build():
	if not safe_to_make_http_request:
		# TODO: Do this better
		$Alert/HBoxContainer/Label.text = "   Wait"
		return
	$CanvasLayer/InteractiveSession.show_alert("building")
	var code = _get_code_to_test()

	var test = coding_resources.tests
	_make_post_request("http://127.0.0.1:5000/code/",
		{"code":code, "test":test}, false)


func _on_req_completed(build_status, result):
	debug_output.text = result
	debug_output.cursor_set_line(debug_output.get_line_count())
	$CanvasLayer/InteractiveSession.show_alert(build_status)

func _get_code_to_test():
	var pre = """def printer():
	"""
	var post = ""
	return pre + coding_ground.text + "\n" + post
	
