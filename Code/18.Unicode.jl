
# Julia uses unicode characters quite heavily. Mostly it is possible to avoid
# using unicode completely, but it can make code look quite clean.
# The unicode autocompletion for vscode mostly works, but can be a bit
# unreliable, but the julia REPL (console) is also useful for writing unicode.
# There is a whole section in the Julia docs dedicated to how to input different
# unicode characters, so just search "Unicode Input" in the docs.

# We've seen a lot of different unicode symbols, here are some more useful ones.

# The infix operator for boolean xor is the ⊻ (\veebar, \xor) symbol.
b = true ⊻ false

# In the LinearAlgebra package the ⋅ (\cdot) symbol is overloaded as the
# scalar product of vectors.
using LinearAlgebra
a = [1, 2] ⋅ [2, 1]
@show a

# Where you would write "in" you could probably use either ∈ (\n) or ∉ (\notin)

# You can use ∈ for iteration
for i ∈ 1 : 5
    # dostuff
end

# It can also be used for checking if an element is in a collection
3 ∈ [1, 2, 3, 4]
# And the notin symbol can be used to check if something isn't in the collection
2 ∉ [1, 2, 3, 4]

# The mathematical constants π (\pi) and ℯ (\euler) are defined as irrationals
# that can be cast to a numeric type and they will be calculated to the
# required precision.

# This calculates pi the the precision of a Float64
p = Float64(π)
@show p

# This will calculate the fraction closest to ℯ using Int16.
e = Rational{Int16}(ℯ)
@show e
