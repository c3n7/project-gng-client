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

var slides = [
"""
[b]How To Define Functions[/b]
A function is a block of instructions that performs an action and, once defined, can be reused. Functions make code more modular, allowing you to use the same code over and over again.

Python has a number of built-in functions that you may be familiar with, including:

  - [code]print()[/code] which will print an object to the terminal
  - [code]int()[/code] which will convert a string or number data type to an integer
data type
  - [code]len()[/code] which returns the length of an object

Function names include parentheses and may include parameters.
In this tutorial, we’ll go over how to define your own functions to use
in your coding projects.
""",
"""
[b]Defining a Function[/b]
Let’s start with turning the classic “Hello, World!” program into a function.

Let's define the function.
A function is defined by using the [code]def[/code] keyword, followed by a name of your choosing, followed by a set of parentheses which hold any parameters the function will take (they can be empty), and ending with a colon.

In this case, we’ll define a function named [code]hello()[/code]:

[code]def hello():[/code]

This sets up the initial statement for creating a function.
""",

	"""
From here, we’ll add a second line with a 4-space indent to provide the instructions for what the function does. In this case, we’ll be printing [code]Hello, World![/code] to the console:

[code]def hello():
  print("Hello, World!")[/code]

Our function is now fully defined, but if we run the program at this point, nothing will happen since we didn’t call the function.

""",

"""
So, outside of our defined function block, let’s call the function with [code]hello():[/code]

[code]def hello():
  print("Hello, World!")

hello()[/code]

Functions can be more complicated than the [code]hello()[/code] function we defined above. For example, we can use for loops, conditional statements, and more within our function block.
""",

"""
[b]Working with Parameters[/b]
So far we have looked at functions with empty parentheses that do not take arguments, but we can define parameters in function definitions within their parentheses.

A parameter is a named entity in a function definition, specifying an argument that the function can accept.

Let’s create a small program that takes in parameters [code]x[/code], [code]y[/code], and [code]z[/code]. We’ll create a function that adds the parameters together in different configurations. The sums of these will be printed by the function. Then we’ll call the function and pass numbers into the function.

""","""
[code]def add_numbers(x, y, z):
	a = x + y
	b = x + z
	c = y + z
	print(a, b, c)

add_numbers(1, 2, 3)[/code]

We passed the number 1 in for the x parameter, 2 in for the y parameter, and 3 in for the z parameter. These values correspond with each parameter in the order they are given.
""",

	"""
The program is essentially doing the following math based on the values we passed to the parameters:

[code]a = 1 + 2
b = 1 + 3
c = 2 + 3[/code]

The function also prints a, b, and c, and based on the math above we would expect a to be equal to 3, b to be 4, and c to be 5. Let’s run the program:

Parameters are arguments that are typically defined as variables within function definitions. They can be assigned values when you run the method, passing the arguments into the function.

""",

	"""
[b]Returning a Value[/b]
You can pass a parameter value into a function, and a function can also produce a value.

A function can produce a value with the [code]return[/code] statement, which will exit a function and optionally pass an expression back to the caller. If you use a return statement with no arguments, the function will return [code]None[/code].

So far, we have used the [code]print()[/code] statement instead of the return statement in our functions. Let’s create a program that instead of printing will return a variable.

Let's create a function that squares the parameter x and returns the variable y. We issue a call to print the [code]result[/code] variable, which is formed by running the [code]square()[/code] function with 3 passed into it.

""",
"""
[code]def square(x):
	y = x ** 2
	return y

result = square(3)
print(result)[/code]

Without using the [code]return[/code] statement here, the program cannot return a value so the value defaults to [code]None[/code].
"""
]
