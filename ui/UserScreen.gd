extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var safe_to_make_http_request = true
var request_made = ""
var user

onready var grid = $BodyMargin/TabContainer/Leaderboard/MarginContainer/GridContainer
onready var contrast_label : Theme = preload("res://themes/contrast_label.tres")
onready var light_label: Theme = preload("res://themes/light_label.tres")
onready var username: LineEdit = $"BodyMargin/TabContainer/My Profile/MarginContainer/HBoxContainer/Username"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score/Label.text = "score: " + str(GameState.get_score())
	var error = $HTTPRequest.connect("request_completed", self, "_on_request_completed")
	if error != OK:
		push_error("Error while connecting signal")
	
	
	user = GameState.get_user()
	
	_try_and_sync()
	
	if user != "":
		$Score/Label.text = user + " " + $Score/Label.text
		
	$"BodyMargin/TabContainer/My Profile/MarginContainer/HBoxContainer/Username".text = user


func _on_request_completed(_result, _response_code, _headers, body):
	safe_to_make_http_request = true
	var json = JSON.parse(body.get_string_from_utf8())
	print_debug(json.result)
	if request_made == "all_scores":
		request_made = ""
		_populate_leaderboard(json.result)
	elif request_made == "set_user":
		_update_user(json.result)
	elif request_made == "try_and_sync":		
		$HTTPRequest.request("http://127.0.0.1:8000/get_all_scores/")
		request_made = "all_scores"


func _populate_leaderboard(scores):
	var i = 0
	for key in scores:
		var u = Label.new()
		u.text = key
		var s = Label.new()
		s.align = Label.ALIGN_RIGHT
		s.text = str(scores[key])
		var j = Label.new()
		j.text = str(i + 1)
		j.align = Label.ALIGN_CENTER
		if i % 2 != 0:
			j.set_theme(contrast_label)
			s.set_theme(contrast_label)
			u.set_theme(contrast_label)
		else:
			j.set_theme(light_label)
			s.set_theme(light_label)
			u.set_theme(light_label)
		i = i + 1
		grid.add_child(j)
		grid.add_child(u)
		grid.add_child(s)
	


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


func _on_SetName_pressed():
	# TODO: Give feedback
	# HACK: Plenty security issues, could be done better
	if user == "":
		# Set a new record
		if username.text == "":
			# TODO: Show error - can't set empty username
			return
		var req_data = {"name": username.text}
		request_made = "set_user"
		_make_post_request("http://127.0.0.1:8000/add_user/", req_data, false)
	else:
		print("Hereheere")
		# Updating set user
		var req_data = {"name": user, "new_name": username.text}
		request_made = "set_user"
		_make_post_request("http://127.0.0.1:8000/update_user/", req_data, false)

func _update_user(result):
	if result["success"] == false:
		# TODO: Show error.
		username.text = user
	else:
		user = result["user"]
		username.text = user
		GameState.set_user(user)
		$Score/Label.text = user + " " + $Score/Label.text
		$HTTPRequest.request("http://127.0.0.1:8000/get_all_scores/")
		request_made = "all_scores"


func _try_and_sync():
	# TODO: Check if HTTP connection exists
	if user != "":
		var req_data = {"name": user, "score": GameState.get_score()}
		_make_post_request("http://127.0.0.1:8000/set_score/", req_data, false)
		request_made = "try_and_sync"
