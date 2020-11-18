extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")

func _on_request_completed(_result, _response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
#	print(json.result)
#	print(headers)
#	print(headers[1])
	print(json.result["summary"])

func _make_post_request(url, data_to_send, use_ssl):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	var error = $HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)
	if error != OK:
		push_error("An error in HTTP request")

func _on_Send_pressed():
	var code = """
class Calculate(object):

	def add(self, x, y):
		return x + y

	def subtract(self, x, y):
		return x - y
"""

	var test = """
import unittest
from calculate import Calculate


class TestCalculate(unittest.TestCase):
	def setUp(self):
		self.calc = Calculate()

	def test_add_method_returns_correct_result(self):
		self.assertEqual(4, self.calc.add(2, 2))

	# def test_subtract_method_returns_correct_result(self):
		# self.assertEqual(2, self.calc.subtract(4, 2))

if __name__ == '__main__':
	unittest.main()
"""
	_make_post_request("http://127.0.0.1:5000/code/",
		{"code":code, "test":test}, false)


func _on_Get_pressed():
	$HTTPRequest.request("http://127.0.0.1:5000")
