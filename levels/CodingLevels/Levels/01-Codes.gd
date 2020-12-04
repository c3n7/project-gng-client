var code = "print(string)"

var tests = """
import io
import sys
import unittest
from calculate import printer


class TestCalculate(unittest.TestCase):
	def test_printer_fn_working(self):
		capturedOutput = io.StringIO()                  # Create StringIO object
		sys.stdout = capturedOutput                     # and redirect stdout.
		printer()                                 # Call function.
		sys.stdout = sys.__stdout__                     # Reset redirect.
		self.assertEqual("hello world!", capturedOutput.getvalue().strip().lower())


if __name__ == '__main__':
	unittest.main()

"""
