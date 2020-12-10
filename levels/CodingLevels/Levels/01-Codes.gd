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
		printer()


if __name__ == '__main__':
	unittest.main()

"""

var slides = [
	"""[b]Hello World[/b]
The “Hello, World!” program is a classic and time-honoured tradition in computer programming. Serving as a simple and complete first program for beginners, as well as a good program to test systems and programming environments, “Hello, World!” illustrates the basic syntax of programming languages.

[i]Code[/i]
[code]print("Hello World!").[/code]

Let’s break down the different components of the code. [i]print()[/i] is a function that tells the computer to perform an action. We know it is a function because it uses parentheses. [i]print()[/i] tells Python to display or output whatever we put in the parentheses. By default, this will output to the current terminal window.

Some functions, like the [i]print()[/i] function, are built-in functions included in Python by default. These built-in functions are always available for us to use in programs that we create.
""",
	"""
We can also define our own functions that we construct ourselves through other elements.

Inside the parentheses of the [i]print()[/i] function is a sequence of characters — [i]Hello, World![/i] — that is enclosed in quotation marks. Any characters that are inside of quotation marks are called a string.
After running the “Hello World!” Program here's the output you'll see:

[i]Output[/i]
[code]  Hello World![/code]

Let’s go over what the program did in more detail. Python executed the line [i]print("Hello, World!")[/i] by calling the [i]print()[/i] function. The string value of Hello, World! was passed to the function.

In this example, the string [i]Hello, World![/i] is also called an argument since it is a value that is passed to a function. The quotes that are on either side of Hello, World! were not printed to the screen because they are used to tell Python that they contain a string. The quotation marks delineate where the string begins and ends.
"""
]

var exercise = """
[b]A time-honored tradition[/b]
Print [code]Hello World![/code]
"""
