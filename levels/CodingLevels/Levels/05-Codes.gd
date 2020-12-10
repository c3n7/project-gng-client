var code = """# Increment Function
def incrementByFive(x):
	x += 5
	return x
"""

var tests = """
import unittest
from user_code import incrementByFive


class TestCalculate(unittest.TestCase):
	def test_increment_method_returns_correct_result(self):
		self.assertEqual(17, incrementByFive(12), 'Increment function wrong')

if __name__ == '__main__':
	unittest.main()
"""

var slides = [
	"""
[b]Assignment Operators[/b]
The most common assignment operator is one you have already used: the equals sign [code]=.[/code] The [code]=[/code] assignment operator assigns the value on the right to a variable on the left. For example, [code]v = 23[/code] assigns the value of the integer [code]23[/code] to the variable [code]v[/code].

When programming, it is common to use compound assignment operators that perform an operation on a variable’s value and then assign the resulting new value to that variable. These compound operators combine an arithmetic operator with the [code]=[/code] operator, so for addition we’ll combine [code]+[/code] with [code]=[/code] to get the compound operator [code]+=[/code]. Let’s see what that looks like:
""",
	"""
[i]Code[/i]
[code]  w = 5
  w += 1
  print(w)[/code]

[i]Output[/i]
[code]6[/code]

First, we set the variable [code]w[/code] equal to the value of [code]5[/code], then we used the [code]+=[/code] compound assignment operator to add the right number to the value of the left variable and then assign the result to [code]w[/code].
""",
	"""
[b]In Summary[/b]
[code]
y += 1      :     add then assign value

y -= 1      :     subtract then assign value

y *= 2      :     multiply then assign value

y /= 3      :     divide then assign value

y // = 5    :     floor divide then assign value

y **= 2     :     increase to the power of then assign value

y %= 3      :     return remainder then assign value[/code]
"""
]

var exercise = """[b]Exercise[/b]

Create a function, call it [code]incrementByFive[/code] such that:
- It should receive one parameter.
- Use the [code]+=[/code] operator to add 5 to the passed value.
- Return the result.

Before building, collect coins in the game to observe that for each coin you pick, the score is incremented by 1.

After building successfully, observe that for each coin you pick, the score is incremented by five for each coin you pick.

Have fun, move the character till you reach the [b]portal door[/b]. Avoid [b]enemies[/b], [b]spikes[/b] and [b]water[/b]
"""
