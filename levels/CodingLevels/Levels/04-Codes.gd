var year = OS.get_date()["year"]
var age = year - 1997
var code = """
name = 'functions'
yob = 1997
age = """ + str(year) + """ - 1997
print(name, yob, age)
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
		expected = 'functions 1997 """ + str(age) + """'
		self.assertEqual(expected, capturedOutput.getvalue().strip().lower())


if __name__ == '__main__':
	unittest.main()

"""
