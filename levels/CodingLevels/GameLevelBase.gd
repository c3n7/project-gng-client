extends Node2D

export (GDScript) var coding_resources_object

var safe_to_make_http_request = true
onready var coding_ground = $CanvasLayer/InteractiveSession/Full/Right/Top/CodingGround
onready var debug_output = $CanvasLayer/InteractiveSession/Full/Right/Bottom/TabContainer/Build/OutputMargin/Output
var coding_resources

# TODO: Move this to a module of its own
func _ready():
	var error = $HTTPRequest.connect("request_completed", self, "_on_request_completed")
	if error != OK:
		push_error("Error while connecting signal")
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


func _on_request_completed(_result, _response_code, _headers, body):
	safe_to_make_http_request = true
	debug_output.text = ""
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result["summary"])
#	print(json.result)
	var buildResult = ""
	var debugOutput = ""
	if json.result["summary"]["collected"] == 0 || json.result["summary"]["total"] == 0:
		buildResult = "error"
		debugOutput = json.result["collectors"][1]["longrepr"] +  "\n\n"
	elif json.result["summary"].has("passed") && json.result["summary"]["collected"] == json.result["summary"]["passed"]:
		buildResult = "success"
		debugOutput = "Congratulations! Success."
		# TODO: Move this somewhere better, like its own function
		var player = $BlueCoding01/Player.get_child(0)
		var spawn_point = Vector2(player.position.x, rand_range(-100, -1000))
		$BlueCoding01.spawn_balloon('blue', spawn_point, 'Hello World!')
	else:
		# TODO: Show help button
		buildResult = "failed"
		# Loop through results
		for result in json.result["tests"]:
			# Find only those that didn't pass
			if result["call"]["outcome"] != "passed":
				debugOutput += result["call"]["crash"]["message"] + "\n"

	debug_output.text = debugOutput
	debug_output.cursor_set_line(debug_output.get_line_count())
	$CanvasLayer/InteractiveSession.show_alert(buildResult)

func _make_post_request(url, data_to_send, use_ssl):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	var error = $HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)
	safe_to_make_http_request = false
	if error != OK:
		push_error("An error in HTTP request")

func _get_code_to_test():
	var pre = """"""
	var post = ""
	return pre + coding_ground.text + "\n" + post
	
