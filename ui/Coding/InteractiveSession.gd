extends Control

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
		coding_ground.add_keyword_color(keyword, Color("#fba922"))

	coding_ground.text = """
class Calculate(object):

	def add(self, x, y):
		return x + y

	def subtract(self, x, y):
		return x - y
	
	def make_multiplier_of(self, n):
		def multiplier(x):
			return x * n
		
		return multiplier
"""


func _on_Build_pressed():
	if not safe_to_make_http_request:
		# TODO: Do this better
		$Alert/HBoxContainer/Label.text = "   Wait"
		return
	show_alert("building")
	var code = coding_ground.text

	var test = """
import unittest
from calculate import Calculate


class TestCalculate(unittest.TestCase):
	def setUp(self):
		self.calc = Calculate()

	def test_add_method_returns_correct_result(self):
		self.assertEqual(5, self.calc.add(3, 2))

	def test_subtract_method_returns_correct_result(self):
		self.assertEqual(7, self.calc.subtract(10, 3))
		
	def test_make_multiplier_makes_multiplier(self):
		doubler = self.calc.make_multiplier_of(2)
		self.assertEqual(18, doubler(9))

if __name__ == '__main__':
	unittest.main()
"""
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
		# TODO: Show Stack Trace
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
	if json.result["summary"]["collected"] == 0 || json.result["summary"]["total"] == 0:
		# TODO: Display the fatal error better
		buildResult = "error"
		debug_output.text = json.result["collectors"][1]["longrepr"]
	elif json.result["summary"]["collected"] == json.result["summary"]["passed"]:
		buildResult = "success"
	else:
		buildResult = "failed"
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
