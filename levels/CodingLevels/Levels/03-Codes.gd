var year = OS.get_date()["year"]
var age = year - 1997
var code = """
a = 1736 * 389
b = 2370 - 439
c = 8 / 2
d = c + b
e = 4 == c
f = d == e
g = a != b
h = c > d
print(a, b, c, d, e, f, g, h)
"""

var tests = """
import io
import sys
import unittest
from user_code import printer


class TestCalculate(unittest.TestCase):
	def test_printer_fn_working(self):
		capturedOutput = io.StringIO()                  # Create StringIO object
		sys.stdout = capturedOutput                     # and redirect stdout.
		printer()                                 # Call function.
		sys.stdout = sys.__stdout__                     # Reset redirect.
		expected = '675304 1931 4.0 1935.0 true false true false'
		self.assertEqual(expected, capturedOutput.getvalue().strip().lower())


if __name__ == '__main__':
	unittest.main()

"""
