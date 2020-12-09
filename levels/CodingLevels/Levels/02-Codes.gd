var year = OS.get_date()["year"]
var age = year - 1997
var code = """
name = "john doe"
yob = 1997
age = """ + str(year) + """ - yob
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
		expected = 'john doe 1997 """ + str(age) + """'
		self.assertEqual(expected, capturedOutput.getvalue().strip().lower())


if __name__ == '__main__':
	unittest.main()

"""

var slides = [
	"""
[b]How to Use Variables[/b]
Variables are an important programming concept to master. They are essentially symbols that stand in for a value you’re using in a program.

This tutorial will cover some variable basics and how to best use them within the Python 3 programs you create.
""",
	"""
[b]Understanding Variables[/b]
In technical terms, a variable is assigning a storage location to a value that is tied to a symbolic name or identifier. The variable name is used to reference that stored value within a computer program.

You can think of a variable as a label that has a name on it, which you tie onto a value.

Let’s say we have an integer, [code]103204934813[/code], and we want to store it in a variable rather than continuously retype the long number over and over again. Instead, let’s use something that’s easy to remember like the variable [code]my_int[/code]:

[code]my_int = 103204934813[/code]
""",
	"""
The label has the variable name [i]my_int[/i] written on it, and is tied to the integer value [i]103204934813.[/i]
The phrase [i]my_int = 103204934813[/i] is an assignment statement, which consists of a few parts:
  - the variable name (my_int)
  - the assignment operator, also known as the equal sign (=)
  - the value that is being tied to the variable name (103204934813)

Together, those three parts make up the statement that sets the variable [i]my_int[/i] equal to the value of the integer [i]103204934813.[/i]

As soon as we set a variable equal to a value, we initialize or create that variable. Once we have done that, we are set to use the variable instead of the value. In Python, variables do not need explicit declaration prior to use like some programming languages; you can start using the variable right away.
""",
	"""
As soon as we set my_int equal to the value of [code]103204934813[/code], we can use [code]my_int[/code] in the place of the integer, so let’s print it out:

[code]print(my_int)[/code]

[b][i]Output[/i][/b]
[code]103204934813[/code]

Using variables, we can quickly and easily do math. Let’s subtract the integer value 813:

[code]print(my_int - 813)[/code]

[b][i]Output[/i][/b]
[code]103204934000[/code]
""",
	"""
In this example, Python does the math for us, subtracting [i]813[/i] from the variable [i]my_int[/i] to return the sum [i]103204934000.[/i] Speaking of math, variables can be set equal to the result of a math equation. Let’s add two numbers together and store the value of the sum into the variable [code]x[/code]:

[code]x = 76 + 145[/code]
Python returned the value 221 because the variable x was set equal to the sum of 76 and 145. Variables can represent any data type, not just integers:

[code]my_string = 'Hello, World!'
my_flt = 45.06
my_bool = 5 > 9 #A Boolean value will return either True or False[/code]
""",
	"""
[b]Naming Variables: Rules and Style[/b]
The naming of variables is quite flexible, but there are some rules you
need to keep in mind:
  - Variable names must only be one word (as in no spaces)
  - Variable names must be made up of only letters, numbers, and underscore (_)
  - Variable names cannot begin with a number.

Something else to keep in mind when naming variables, is that they are case-sensitive, meaning that [code]my_int[/code], [code]MY_INT[/code], [code]My_Int[/code], and [code]mY_iNt[/code] are all completely different variables.
""",
	"""
[b]Reassigning Variables[/b]
As the word variable implies, Python variables can be readily changed. This means that you can connect a different value with a previously assigned variable very easily through simple reassignment.

Being able to reassign is useful because throughout the course of a program, you may need to accept user-generated values into already initialized variables, or may have to change the assignment to something you previously defined.

Knowing that you can readily and easily reassign a variable can also be useful in situations where you may be working on a large program that was begun by someone else and you are not clear yet on what has already been defined.
Let’s assign x first as an integer, and then reassign it as a string:
""",
	"""
[code]#Assign x to be an integer
x = 76
print(x)

#Reassign x to be a string
x = "Sammy"
print(x)[/code]
	"""
]

var exercise = """
[b]Set these variables[/b]
- [code]name[/code] to the string [code]john doe[/code]
- [code]yob[/code] to the number [code]1997[/code]
- [code]age[/code] to the current year (e.g. 2021) minus yob
- Print all the three like :`
				[code]print(name, yob, age)[/code]
"""
