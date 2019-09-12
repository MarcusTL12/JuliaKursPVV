
# Standard function definition
function f(x, y)
    return x + y
end

# Function implicitly returns the value of the last line
# of the function so no return keyword is required
function g(x, y)
    x - y
end

# Functions can be defined one one line like this.
# This is just a shorthand and is compiled identically to the ones above
h(x, y) = x * y


# Can enforce types on function arguments and return value
# This makes it possible to create multiple functions
# with the same name but different types; These are called methods
f(x::Float64, y::Float64)::Float64 = x / y


# Runs the generic method of the function at the top of the file
println(f(2, 3))

# Runs the specific method defined for two Float64.
println(f(2.2, 3.2))

# Also falls back the the generic method as input is (::Float64, ::Int64)
println(f(1.6, 3))
