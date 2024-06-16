# CC:NumberWorks

## What it is

CC:NumberWorks is a Reverse Polish Notation (RPN) language, written in Lua for ComputerCraft systems.

If you are unfamiliar with RPN languages, here's a crash course:

An RPN language is written with the operator on the right, and the operands on the left, i.e. "3 + 5" is written as `3 5 +`. This allows the computer to use a simple evaluation algorithm:

- When a number is encountered, push it to a _stack_
- When an operator is encountered, take a number of values off the top of the stack, perform an operation, and push it back.

This works, however right now it's nothing more than a scientific calculator. To fix this, lets add two new constructs: _symbols_ and _procedures_. Symbols are simply strings with no whitespace, written as a series of characters with a hash in front of them, i.e. `#hello`. 

Procedures are slightly more complicated. They consist of a series of words wrapped in braces, and are pushed to the stack rather than directly executed. For example, writing `{3 5 +}` would not push 8 to the stack, but rather the code itself. You may recognize this as an anonymous function. Finally, we can establish a _dictionary_, which maps symbols to procedures, this allows us to create custom words to abstract away lengthy pipelines.

A side effect of procedures is that we can now implement control flow using simple words. For example, type `{3 5 <} {#yes .} if` at the prompt. It should print "yes". Now, flip the `<` to a `>`. It should print nothing.

## Installing

To install, run these commands at the CraftOS terminal:

```shell
pastebin get ykJehDhU startup
pastebin get wPDgmLCT library
```

_p.s. if someone can figure out how to install directly from this repo that would be highly appreciated_

