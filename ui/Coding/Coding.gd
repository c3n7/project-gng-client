extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var keywords = [
	"False", "await", "else", "import", "pass",
	"None", "break", "except", "in", "raise",
	"True", "class", "finally", "is", "return",
	"and", "continue", "for", "lambda", "try",
	"as", "def", "from", "nonlocal", "while",
	"assert", "del", "global", "not", "with",
	"async", "elif", "if", "or", "yield"]


# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	for keyword in keywords:
		$HBoxContainer/TextEdit.add_keyword_color(keyword, Color("#fba922"))

	$HBoxContainer/TextEdit.text = """
class Calculate(object):

	def add(self, x, y):
		return x + y

	def subtract(self, x, y):
		return x - y
"""


func _on_Build_pressed():
	$Alert/HBoxContainer/Label.text = "Building"
	$Alert/AnimationPlayer.play("slide_in_out")
	var code = $HBoxContainer/TextEdit.text

	var test = """
import unittest
from calculate import Calculate


class TestCalculate(unittest.TestCase):
	def setUp(self):
		self.calc = Calculate()

	def test_add_method_returns_correct_result(self):
		self.assertEqual(4, self.calc.add(2, 2))

	def test_subtract_method_returns_correct_result(self):
		self.assertEqual(2, self.calc.subtract(4, 2))

if __name__ == '__main__':
	unittest.main()
"""
	_make_post_request("http://127.0.0.1:5000/code/",
		{"code":code, "test":test}, false)


func _on_request_completed(_result, _response_code, _headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
#	print(json.result)
#	print(headers)
#	print(headers[1])
	print(json.result["summary"])
	print(json.result["tests"][0]["keywords"])
	print(json.result["tests"][0]["outcome"])

func _make_post_request(url, data_to_send, use_ssl):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	var error = $HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)
	if error != OK:
		push_error("An error in HTTP request")
