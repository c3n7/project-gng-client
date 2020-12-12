extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var safe_to_make_http_request = true
var request_made = ""

onready var grid = $BodyMargin/TabContainer/Leaderboard/GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score/Label.text = "score: " + str(GameState.get_score())
	var error = $HTTPRequest.connect("request_completed", self, "_on_request_completed")
	if error != OK:
		push_error("Error while connecting signal")
	
	$HTTPRequest.request("http://127.0.0.1:8000/get_all_scores/")
	request_made = "all_scores"


func _on_request_completed(_result, _response_code, _headers, body):
	safe_to_make_http_request = true
	var json = JSON.parse(body.get_string_from_utf8())
	print(json)
	print_debug(json.result)
	if request_made == "all_scores":
		request_made = ""
		_populate_leaderboard(json.result)

func _populate_leaderboard(scores):
	for key in scores:
		var u = Label.new()
		u.text = key
		var s = Label.new()
		s.text = str(scores[key])
		grid.add_child(u)
		grid.add_child(s)
		print(key + " " + str(scores[key]))

func _make_post_request(url, data_to_send, use_ssl):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	var error = $HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)
	safe_to_make_http_request = false
	if error != OK:
		push_error("An error in HTTP request")

func _on_BackButton_pressed():
	GameState.open_title_screen()
