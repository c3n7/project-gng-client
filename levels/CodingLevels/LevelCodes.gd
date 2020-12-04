extends Control

var classes_code = """# Calculate Class
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

var classes_tests = """
import unittest
from calculate import Calculate


class TestCalculate(unittest.TestCase):
	def setUp(self):
		self.calc = Calculate()

	def test_add_method_returns_correct_result(self):
		self.assertEqual(5, self.calc.add(3, 2), 'Addition function not working')

	def test_subtract_method_returns_correct_result(self):
		self.assertEqual(7, self.calc.subtract(10, 3), 'Subtraction function not working')
		
	def test_make_multiplier_makes_multiplier(self):
		doubler = self.calc.make_multiplier_of(2)
		self.assertEqual(18, doubler(9), 'closure not working')

if __name__ == '__main__':
	unittest.main()
"""
