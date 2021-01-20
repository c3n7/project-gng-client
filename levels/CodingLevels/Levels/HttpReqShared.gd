extends Node2D

export (GDScript) var coding_resources_object
export (Theme) var interactive_session_theme
export (Theme) var output_panel_theme

signal req_complete(build_status, result)

var safe_to_make_http_request = true

var coding_resources # Contains the slides, code, tests and exercise

var currentSlide = 0
var slidesCount

# widget variables
# TODO: Add static typing
var coding_ground
var debug_output
var slides
var slideCountLabel
var exercises
var pause_screen
var game_level
var interactive_session
var alert
var reward
var httpreq : HTTPRequest

var startTime

func init():
	var error = httpreq.connect("request_completed", self, "_on_request_completed")
	if error != OK:
		push_error("Error while connecting signal")

func _on_request_completed(_result, _response_code, _headers, body):
	safe_to_make_http_request = true
	var json = JSON.parse(body.get_string_from_utf8())
	print_debug(json.result["summary"])
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
		# TODO: Show help button
		buildResult = "failed"
		# Loop through results
		for result in json.result["tests"]:
			# Find only those that didn't pass
			if result["call"]["outcome"] != "passed":
				debugOutput += result["call"]["crash"]["message"] + "\n"

	emit_signal("req_complete", buildResult, debugOutput)

func _make_post_request(url, data_to_send, use_ssl):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	var error = $HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)
	safe_to_make_http_request = false
	if error != OK:
		push_error("An error in HTTP request")

func _test_code(code, test, alert_label):
	if not safe_to_make_http_request:
		# TODO: Do this better
		alert_label.text = "   Wait"
		return
	interactive_session.show_alert("building")
	_make_post_request("http://127.0.0.1:5000/code/",
		{"code":code, "test":test}, false)


func _on_game_won():
	GameState.open_levels_screen()

func _on_next_slide():
#	interactive_session.show_reward("  High\n  Achiever")
	currentSlide += 1
	if currentSlide >= slidesCount:
		currentSlide = slidesCount - 1
	
	slideCountLabel.text = str(currentSlide + 1) + " of " + str(slidesCount)
	slides.bbcode_text = coding_resources.slides[currentSlide]

func _on_prev_slide():
	currentSlide -= 1
	if currentSlide <= 0:
		currentSlide = 0
	
	slideCountLabel.text = str(currentSlide + 1) + " of " + str(slidesCount)
	slides.bbcode_text = coding_resources.slides[currentSlide]

func _process(_delta):
	var slide_next = Input.is_action_just_pressed("slide_next")
	var slide_prev = Input.is_action_just_pressed("slide_prev")
	var exit_game = Input.is_action_just_pressed("exit_game")
	
	if slide_next:
		_on_next_slide()
	elif slide_prev:
		_on_prev_slide()
	
	if exit_game:
		GameState.open_title_screen()


func _get_nodes():
	pass

func _success(build_status):
	# placeholder code, achieves nothing
	build_status = build_status

# This function serves no special purpose, move it and delete signal
func _on_req_complete(build_status, result):
	debug_output.text = result
	debug_output.cursor_set_line(debug_output.get_line_count())
	interactive_session.show_alert(build_status)
	_success(build_status)

func _ready():
	startTime = OS.get_time()
	_get_nodes()
	init()
	var error = connect("req_complete", self, "_on_req_complete")
	if error != OK:
		print_debug("Error while connecting to req_completed signal")
		
	# Fill text objects
	coding_resources = coding_resources_object.new()
	coding_ground.text = coding_resources.code
	exercises.bbcode_text = coding_resources.exercise
	
	slides.bbcode_text  = coding_resources.slides[currentSlide]
	slidesCount = coding_resources.slides.size()
	slideCountLabel.text = str(currentSlide + 1) + " of " + str(slidesCount)
	
	# Themes
	interactive_session.set_theme(interactive_session_theme)
	debug_output.set_theme(output_panel_theme)
	alert.set_theme(output_panel_theme)
	reward.set_theme(output_panel_theme)
	pause_screen.set_theme(interactive_session_theme)
	
	# For the slides
	error = interactive_session.connect("next_slide", self, "_on_next_slide")
	if error != OK:
		print_debug("Error while connecting to next_slide signal")
	error = interactive_session.connect("prev_slide", self, "_on_prev_slide")
	if error != OK:
		print_debug("Error while connecting to next_slide signal")
	
	game_level.connect("game_won", self, "_on_game_won")

func _exit_tree():
	var startedAt = (startTime.hour * 60 * 60) + (startTime.minute * 60) + startTime.second
	var currentTime = OS.get_time()
	var endedAt = (currentTime.hour * 60 * 60) + (currentTime.minute * 60) + currentTime.second
	var totalTime = endedAt - startedAt
	GameState.add_play_time(totalTime)
	print_debug("Time = ", totalTime)
	print_debug("Total time = ", GameState.get_play_time())
