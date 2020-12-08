var code = "print(string)"

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
		self.assertEqual("hello world!", capturedOutput.getvalue().strip().lower())
		
	def tearDown(self):
		print('Take heed, son, you word is not code')


if __name__ == '__main__':
	unittest.main()

"""
