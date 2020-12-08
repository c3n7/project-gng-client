var code = """# Addition and Multiplication Functions
def add(x, y):
		return x + y

def multiply(x, y):
		return x * y
"""

var tests = """
import unittest
from user_code import add
from user_code import multiply


class TestCalculate(unittest.TestCase):
	def test_add_method_returns_correct_result(self):
		self.assertEqual(5, add(3, 2), 'Addition function not working')

	def test_multiply_method_returns_correct_result(self):
		self.assertEqual(30, multiply(10, 3), 'Multiply function not working')

if __name__ == '__main__':
	unittest.main()
"""
