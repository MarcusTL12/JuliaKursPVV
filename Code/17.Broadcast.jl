
# The broadcast operator (.) can be quite useful when dealing with arrays.
# Basically whenever an operator or function is used, you can just write
# a dot (.) before the operator/function to make it act elementwise.

# Here we elementwise add 3 to the array
a = [1, 2, 3, 4]
a .+= 3
@show a

# Here we elementwise multiply a by 2 and then elementwise add a and b.
b = a .* 2
@show b
c = a .+ b
@show c

# To elementwise use more general functions the dot symbol is placed between
# the function name and parentheses.
f(x) = 2x^2
d = f.(c)
@show d
