
# A lambda function is made with an arrow from the arguments
# to the function body
f = x -> 2x^2
@show f(2)

# If the function takes more then one argument, parentheses are required
g = (x, y) -> x * y
@show g(2, 3)

# This also holds for functions taking no arguments
p = () -> Float64(π)
@show p()

# Function currying is possible, so if anyone wants to do lambda calculus
# feel free.
h = x -> y -> x / y
@show h(12)(4)

# If a function has to be written over multiple lines, this can be done
# with a "begin" block.
fib = n -> begin
    a, b = 0, 1
    for i in 1 : n
        a, b = b, a + b
    end
    a
end
@show fib.(0:6)

# Lambdas can be useful when passing a function as an argument
# without wanting to give it a name. Here is an example using a lambda
# instead of using the do-syntax for file handling
s = open(io -> String(read(io)), "test.txt", "r")
println(s)
