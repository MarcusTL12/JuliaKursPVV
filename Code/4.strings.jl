
# Strings are made with double quotes ""
# Single quotes '' are reserved for single characters (i.e. c/c++)
s = "Hello world"
println(s)


# When converting to a string the function string (with lower case s)
# is used.
a = 3.14
s = string(a)

println(s) # Prints 3.14


# The length of a string can be found with the length function
# similar to len in python

@show length(s)


# The function String (with upper case S) is used for more direct
# interpretation of data as a string

a = UInt8[65, 66, 67] # ASCII codes for "ABC"

println(String(a)) # Prints ABC
println(string(a)) # Prints UInt8[0x41, 0x42, 0x43]


# When converting from string to some numeric value, the parse function
# is used. This function takes in the type to try to parse to as well
# as the string to parse.
s = "128"
a = parse(Int, s)

@show a

s = "3.14"
a = parse(Float64, s)

@show a


# Easy inline string formatting can be done with the $ (eval) symbol
a, b = 3, 5

s = "a, b = $a, $b" # generates string "a, b = 3, 5"
println(s)

s = "a + b = $(a + b)" # "a + b = 8"
println(s)

# However it is usually faster (performance-wise) to just pass in
# multiple arguments to f.ex. println
println("a + b = ", a + b)


# The "raw" string macro is very useful when copying raw text and not
# wanting to worry about special characters doing special stuff
# (i.e. \n for new line). A common use for this is filepaths

filepath = raw"C:\Users\somefolder\somefile.txt"
@show filepath

# String concatenation is, somewhat weirdly, done with the * sign
# instead of the + sign. Julia's justification for this is that
# addition (+) is reserved for commutative operations (a + b = b + a)
# and since string concatenation is not commutative it gets the multiplication
# symbol instead.
s = "foo" * "bar"
println(s)

# This by extension means that if you want to repeat a string n times
# this is done with the exponentiation (^) sign
s = "foo"^5
println(s)

# To get input from the console this can be done with the readline() function
# However getting console input when running in vscode with F5/shift+enter
# seems to crash for some reason, so avoid console input if that''s how you
# run the program
# s = readline()
# println(s)
