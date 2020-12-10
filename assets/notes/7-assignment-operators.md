**Assignment Operators**
The most common assignment operator is one you have already used: the equals sign `=.` The `=` assignment operator assigns the value on the right to a variable on the left. For example, `v = 23` assigns the value of the integer `23` to the variable `v`.

When programming, it is common to use compound assignment operators that perform an operation on a variable’s value and then assign the resulting new value to that variable. These compound operators combine an arithmetic operator with the `=` operator, so for addition we’ll combine `+` with `=` to get the compound operator `+=`. Let’s see what that looks like:

```python
  w = 5
  w += 1
  print(w)
```

Output
```text
6
```

First, we set the variable `w` equal to the value of `5`, then we used the `+=` compound assignment operator to add the right number to the value of the left variable and then assign the result to `w`.


**In Summary**
```text
y += 1          # add then assign value

y -= 1          # subtract then assign value

y *= 2          # multiply then assign value

y /= 3          # divide then assign value

y // = 5        # floor divide then assign value

y **= 2         # increase to the power of then assign value

y %= 3          # return remainder then assign value
```

**Exercise**
Create a function, call it `incrementByFive` such that:
- It should receive a single parameter.
- Use the `+=` operator to add 5 to the passed value.
- Return the result.

Before building, collect coins in the game to observe that for each coin you pick, the score is incremented by 1.

After building successfully, observe that for each coin you pick, the score is incremented by five for each coin you pick.
