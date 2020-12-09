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
	
	def tearDown(self):
		printer()


if __name__ == '__main__':
	unittest.main()

"""

var slides = [
	"""
[b]How to Do Math with Operators[/b]
Numbers are extremely common in programming.

Being able to effectively perform mathematical operations in programming is an important skill to develop because of how frequently you’ll be working with numbers. Though a high-level understanding of mathematics can certainly help you become a better programmer, it is not a prerequisite.

We’ll be working with two of Python’s most used numeric data types, integers and floats:

- [i]Integers[/i] are whole numbers that can be positive, negative, or 0 (…, -1, 0, 1, …).
- [i]Floats[/i] are real numbers, they contain a decimal point (as in 9.0 or -2.25).

This tutorial will go over operators that can be used with number data types in Python.
""",
	"""
[b]Operators[/b]
An operator is a symbol or function that indicates an operation.

Here is a quick reference table of math-related operators in Python. We’ll be covering all of the following operations in this tutorial.
""",
	"""
[code]x + y[/code] : Sum of x and y
[code]x - y[/code]	: Difference of x and y
[code]-x[/code]	: Changed sign of x
[code]+x[/code]	: Identity of x
[code]x * y[/code]	: Product of x and y
[code]x / y[/code]	: Quotient of x and y
[code]x // y[/code]	: Quotient from floor division of x and y
[code]x % y[/code]	: Remainder of x / y
[code]x ** y[/code] :	x to the y power

We’ll also be covering compound assignment operators, including [code]+=[/code] and [code]*=[/code], that combine an arithmetic operator with the [code]=[/code] operator.
""",
	"""
[b]Addition and Subtraction[/b]
In Python, addition and subtraction operators perform just as they do in mathematics. In fact, you can use the Python programming language as a calculator.

Let’s look at some examples, starting with integers:

[code]print(1 + 5)[/code]

[i]Output[/i]
[code]6[/code]
""",
	"""
Instead of passing integers directly into the [code]print[/code] statement, we can initialize variables to stand for integer values:

[code]a = 88
b = 103

print(a + b)[/code]

[i]Output[/i]
[code]191[/code]
""",
	"""
Addition will behave similarly with floats:
[code]e = 5.5
f = 2.5

print(e + f)[/code]

[i]Output[/i]
[code]8.0[/code]

Because we added two floats together, Python returned a float value with a decimal place.
""",
	"""
The syntax for subtraction is the same as for addition, except you’ll change your operator from the plus sign ([code]+[/code]) to the minus sign ([code]-[/code]):

[code]g = 75.67
h = 32

print(g - h)[/code]

[i]Output[/i]
[code]43.67[/code]
Here, we subtracted an integer from a float. Python will return a float if at least one of the numbers involved in an equation is a float.
""",
	"""
[b]Multiplication and Division[/b]
Like addition and subtraction, multiplication and division will look very similar to how they do in mathematics. The sign we’ll use in Python for multiplication is [code]*[/code] and the sign we’ll use for division is [code]/[/code].

Here’s an example of doing multiplication in Python with two float values:

[code]k = 100.1
l = 10.1

print(k * l)[/code]

[i]Output[/i]
[code]1011.0099999999999[/code]
""",
	"""
When you divide in Python 3, your quotient will always be returned as a float, even if you use two integers:

[code]m = 80
n = 5

print(m / n)[/code]

[i]Output[/i]
[code]16.0[/code]
""",
	"""
[b]Modulo[/b]
The [code]%[/code] operator is the modulo, which returns the remainder rather than the quotient after division. This is useful for finding numbers that are multiples of the same number, for example.

Let’s look at the modulo in action:

[code]o = 85
p = 15

print(o % p)[/code]

[i]Output[/i]
[code]10[/code]

To break this down, 85 divided by 15 returns the quotient of 5 with a remainder of 10. The value 10 is what is returned here because the modulo operator returns the remainder of a division expression.
""",
	"""
If we use two floats with the modulo, a float value will be returned for the remainder:

[code]q = 36.0
r = 6.0

print(o % p)[/code]

[i]Output[/i]
[code]0.0[/code]

In the case of 36.0 divided by 6.0, there is no remainder, so the value of 0.0 is returned.
""",
	"""
[b]Power[/b]
The [code]**[/code] operator in Python is used to raise the number on the left to the power of the exponent of the right. That is, in the expression 5 ** 3, 5 is being raised to the 3rd power. What is really going on is 5 is being multiplied by itself 3 times. In Python, we would get the same result of 125 by running either [code]5 ** 3[/code] or [code]5 * 5 * 5[/code].

Let’s look at an example with variables:

[code]s = 52.25
t = 7

print(s ** t)[/code]
""",
	"""
[i]Output[/i]
[code]1063173305051.292[/code]

Raising the float 52.25 to the power of 7 through the [code]**[/code] operator results in a large float value returned.
"""
]


var exercise = """
[b]Set the following variables[/b]
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
