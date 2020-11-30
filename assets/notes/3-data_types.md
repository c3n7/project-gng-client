Understanding Data Types
In Python, like in all programming languages, data types are used to classify one particular type of data. This is important because the specific data type you use will determine what values you can assign to it and what you can do to it (including what operations you can perform on it). In this tutorial, we will go over the important data types native to Python. This is not an exhaustive investigation of data types, but will help you become familiar with what options you have available to you in Python.


Background
One way to think about data types is to consider the different types of data that we use in the real world. An example of data in the real world are numbers: we may use whole numbers (0, 1, 2, …), integers (…, -1, 0, 1, …), and irrational numbers (3.142), for example. 

Usually, in math, we can combine numbers from different types, and get some kind of an answer. We may want to add 5 to 3.142, for example:
```python
5 + 3.142
```

But, if we start to try to evaluate numbers with another data type, such as words, things start to make less sense. How would we solve for the following equation?

```python
sky + 8
```

For computers, each data type can be thought of as being quite different, like words and numbers, so we will have to be careful about how we use them to assign values and how we manipulate them through operations.


Numbers
Any number you enter in Python will be interpreted as a number; you are not required to declare what kind of data type you are entering.

Python will consider any number written without decimals as an integer (as in *138*) and any number written with decimals as a float (as in *138.0*).


Integers
Like in math, integers in computer programming are whole numbers that can be positive, negative, or 0 (…, -1, 0, 1, …). An integer can also be known as an int. As with other programming languages, you should not use commas in numbers of four digits or more, so when you write 1,000 in your program, write it as 1000.
We can print out an integer in a simple way like this:
```python
print(-25)
```

Or, we can declare a variable, which in this case is essentially a symbol of the number we are using or manipulating, like so:

```python
my_int = -25
print(my_int)
```

We can do math with integers in Python, too:
```python
int_ans = 116 - 68
print(int_ans)
```


Floating-Point Numbers
A floating-point number or a float is a real number, meaning that it can be either a rational or an irrational number. Because of this, floating-point numbers can be numbers that can contain a fractional part, such as *9.0* or *-116.42*. Simply speaking, for the purposes of thinking of a float in a Python program, it is a number that contains a decimal point. Like we did with the integer, we can print out a floating-point number
in a simple way like this:
```python
print(17.3)
```

We can also declare a variable that stands in for a float, like so:
```python
my_flt = 17.3
print(my_flt)
```

And, just like with integers, we can do math with floats in Python, too:
```python
flt_ans = 564.0 + 365.24
print(flt_ans)
```

With integers and floating-point numbers, it is important to keep in
mind that 3 ≠ 3.0, as 3 refers to an integer while 3.0 refers to a float.


Booleans
The Boolean data type can be one of two values, either *True* or *False*.
Booleans are used to represent the truth values that are associated with the logic branch of mathematics, which informs algorithms in computer science.

Whenever you see the data type Boolean, it will start with a capitalized B because it is named for the mathematician George Boole. The values *True* and *False* will also always be with a capital T and F respectively, as they are special values in Python.

Many operations in math give us answers that evaluate to either *True* or *False*:
  greater than
  ```python
    500 > 100 True
    1 > 5 False
  ```
  less than
  ```python
    200 < 400 True
    4 < 2 False
  ```
  equal
  ```python
    5 = 5 True
    500 = 400 False
  ```

Like with numbers, we can store a Boolean value in a variable:
```python
my_bool = 5 > 8
```

We can then print the Boolean value with a call to the print()
function:

```python
print(my_bool)
```

Since 5 is not greater than 8, we will receive the following output:
**Output**
```python
False
```


Strings
A string is a sequence of one or more characters (letters, numbers, symbols) that can be either a constant or a variable. Strings exist within either single quotes ' or double quotes " in Python, so to create a string, enclose a sequence of characters in quotes:

```python
'This is a string in single quotes.'
"This is a string in double quotes."
```

You can choose to use either single quotes or double quotes, but whichever you decide on you should be consistent within a program. The simple program “Hello, World!” demonstrates how a string can be used in computer programming, as the characters that make up the phrase *Hello, World!* are a string.

```python
print("Hello, World!")
```

As with other data types, we can store strings in variables:

```python
hw = "Hello, World!"
```

And print out the string by calling the variable:

```python
print(hw)
```

Output

```python
Hello, World!
```
Like numbers, there are many operations that we can perform on strings within our programs in order to manipulate them to achieve the results we are seeking. Strings are important for communicating information to the user, and for the user to communicate information back to the program.
