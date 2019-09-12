
# File IO is really similar to how it would be done in python and C.

io = open("test.txt", "w") # Opens test.txt for writing
write(io, "Hello World!") # writes a string to it
close(io) # closes the file

# However the more appropriate way to do it would be more similar to
# Python's "with" statement. This encloses the file handling in a code block
# and automatically closes the filestream and does cleanup if anything goes
# wrong.
open("test.txt", "w") do io
    write(io, "Hello\nWorld!")
end

# The do-syntax here is really just syntactical sugar for giving the
# open() function a function as an argument

# The following syntax is effectively what the do-syntax above does.
# Create a function taking in a single argument with the file-handling code
function f(io)
    write(io, "Hello\nWorld!")
end

# call the open function with this function as the first parameter
open(f, "test.txt", "w")

# This makes for some really clean and safe file handling syntax.
s = open("test.txt", "r") do io
    collect(eachline(io))
end
display(s)

# for simple functions as the one above it is possible to just pass
# the the function directly in without using the do-syntax
# for a really compact one line function call
# The ∘ symbol is function composition (from mathematics)
s = open(collect ∘ eachline, "test.txt", "r")
display(s)
