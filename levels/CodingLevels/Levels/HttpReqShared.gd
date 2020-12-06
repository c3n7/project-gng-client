extends Node2D

signal req_complete(build_status, result)

var safe_to_make_http_request = true

func init(httpreq):
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

func _test_code(code, test, alert_label, interactive_session):
	if not safe_to_make_http_request:
		# TODO: Do this better
		alert_label.text = "   Wait"
		return
	interactive_session.show_alert("building")
	_make_post_request("http://127.0.0.1:5000/code/",
		{"code":code, "test":test}, false)
