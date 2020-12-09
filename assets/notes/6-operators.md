**How to Do Math with Operator**
Numbers are extremely common in programming.

Being able to effectively perform mathematical operations in programming is an important skill to develop because of how frequently you’ll be working with numbers. Though a high-level understanding of mathematics can certainly help you become a better programmer, it is not a prerequisite.

We’ll be working with two of Python’s most used numeric data types, integers and floats:

- *Integers* are whole numbers that can be positive, negative, or 0 (…, -1, 0, 1, …).
- *Floats* are real numbers, they contain a decimal point (as in 9.0 or -2.25).

This tutorial will go over operators that can be used with number data types in Python.

**Operators**
An operator is a symbol or function that indicates an operation.

Here is a quick reference table of math-related operators in Python. We’ll be covering all of the following operations in this tutorial.

[center]
`x + y` : Sum of x and y
`x - y`	: Difference of x and y
`-x`	: Changed sign of x
`+x`	: Identity of x
`x * y`	: Product of x and y
`x / y`	: Quotient of x and y
`x // y`	: Quotient from floor division of x and y
`x % y`	: Remainder of x / y
`x ** y` :	x to the y power
[/center]

We’ll also be covering compound assignment operators, including `+=` and `*=`, that combine an arithmetic operator with the `=` operator.


**Addition and Subtraction**
In Python, addition and subtraction operators perform just as they do in mathematics. In fact, you can use the Python programming language as a calculator.

Let’s look at some examples, starting with integers:

```python
print(1 + 5)
```

*Output*
```text
6
```

Instead of passing integers directly into the `print` statement, we can initialize variables to stand for integer values:

```python
a = 88
b = 103

print(a + b)
```

Output
```text
191
```


Addition will behave similarly with floats:
```python
e = 5.5
f = 2.5

print(e + f)
```

*Output*
```text
8.0
```
Because we added two floats together, Python returned a float value with a decimal place.

The syntax for subtraction is the same as for addition, except you’ll change your operator from the plus sign (`+`) to the minus sign (`-`):

```python
g = 75.67
h = 32

print(g - h)
```

```text
Output
43.67
```

Here, we subtracted an integer from a float. Python will return a float if at least one of the numbers involved in an equation is a float.


**Multiplication and Division**
Like addition and subtraction, multiplication and division will look very similar to how they do in mathematics. The sign we’ll use in Python for multiplication is `*` and the sign we’ll use for division is `/`.

Here’s an example of doing multiplication in Python with two float values:

```python
k = 100.1
l = 10.1

print(k * l)
```

*Output*
```text
1011.0099999999999
```

When you divide in Python 3, your quotient will always be returned as a float, even if you use two integers:


```python
m = 80
n = 5

print(m / n)
```

*Output*
```text
16.0
```

**Modulo**
The `%` operator is the modulo, which returns the remainder rather than the quotient after division. This is useful for finding numbers that are multiples of the same number, for example.

Let’s look at the modulo in action:

```python
o = 85
p = 15

print(o % p)
```

*Output*
```text
10
```

To break this down, 85 divided by 15 returns the quotient of 5 with a remainder of 10. The value 10 is what is returned here because the modulo operator returns the remainder of a division expression.

If we use two floats with the modulo, a float value will be returned for the remainder:

```python
q = 36.0
r = 6.0

print(o % p)
```

Output
```text
0.0
```

In the case of 36.0 divided by 6.0, there is no remainder, so the value of 0.0 is returned.


**Power**
The `**` operator in Python is used to raise the number on the left to the power of the exponent of the right. That is, in the expression 5 ** 3, 5 is being raised to the 3rd power. What is really going on is 5 is being multiplied by itself 3 times. In Python, we would get the same result of 125 by running either `5 ** 3` or `5 * 5 * 5`.

Let’s look at an example with variables:

```python
s = 52.25
t = 7

print(s ** t)
```

*Output*
```text
1063173305051.292
```

Raising the float 52.25 to the power of 7 through the `**` operator results in a large float value returned.
