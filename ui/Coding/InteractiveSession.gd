extends "res://levels/CodingLevels/LevelCodes.gd"

signal show_balloon(quantity)

onready var coding_ground = $Full/Right/Top/CodingGround
onready var debug_output = $Full/Right/Bottom/TabContainer/Build/OutputMargin/Output

var keywords = [
	"False", "await", "else", "import", "pass",
	"None", "break", "except", "in", "raise",
	"True", "class", "finally", "is", "return",
	"and", "continue", "for", "lambda", "try",
	"as", "def", "from", "nonlocal", "while",
	"assert", "del", "global", "not", "with",
	"async", "elif", "if", "or", "yield"]

var safe_to_make_http_request = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var error = $HTTPRequest.connect("request_completed", self, "_on_request_completed")
	if error != OK:
		push_error("Error while connecting signal")
	for keyword in keywords:
		coding_ground.add_color_region("#", '', Color("#686868"))
		coding_ground.add_keyword_color(keyword, Color("#fba922"))

	coding_ground.text = classes_code


func _on_Build_pressed():
	# TODO: Remove this line
	emit_signal("show_balloon", 1)
	if not safe_to_make_http_request:
		# TODO: Do this better
		$Alert/HBoxContainer/Label.text = "   Wait"
		return
	show_alert("building")
	var code = coding_ground.text

	var test = classes_tests
	_make_post_request("http://127.0.0.1:5000/code/",
		{"code":code, "test":test}, false)


func show_alert(image):
	if $Alert/AnimationPlayer.is_playing():
		# If animation is already playing, wait first
		yield($Alert/AnimationPlayer, "animation_finished")
	
	# HACK: Add padding better
	var labelText = ""
	match image:
		"success":
			$Alert/Panel/Building.hide()
			$Alert/Panel/Failure.hide()
			$Alert/Panel/Success.show()
			labelText = "   Success"
		"failed":
			$Alert/Panel/Building.hide()
			$Alert/Panel/Failure.show()
			$Alert/Panel/Success.hide()
			labelText = "   Failed"
		# TODO: Show help button
		"error":
			$Alert/Panel/Building.hide()
			$Alert/Panel/Failure.show()
			$Alert/Panel/Success.hide()
			labelText = "   Error"
		"building":
			$Alert/Panel/Building.show()
			$Alert/Panel/Failure.hide()
			$Alert/Panel/Success.hide()
			labelText = "   Building"
	
	$Alert/HBoxContainer/Label.text = labelText
	$Alert/AnimationPlayer.play("slide_in_out")
	$Whoosh.play()
	
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
	else:
		buildResult = "failed"
		# Loop through results
		for result in json.result["tests"]:
			# Find only those that didn't pass
			if result["call"]["outcome"] != "passed":
				debugOutput += result["call"]["crash"]["message"] + "\n"
	
	debug_output.text = debugOutput
	debug_output.cursor_set_line(debug_output.get_line_count())
	show_alert(buildResult)

func _make_post_request(url, data_to_send, use_ssl):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	var error = $HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)
	safe_to_make_http_request = false
	if error != OK:
		push_error("An error in HTTP request")
