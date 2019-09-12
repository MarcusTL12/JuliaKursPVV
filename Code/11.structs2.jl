
# This is just a super simple example to illustrate the "call" operator.

# Simple polynomial type. The Polynomials.jl package is basically a more
# complete version of this example.
struct Poly{T}
    coeffs::Vector{T}
end

# Could implement a whole bunch of operators (+, -, *, /, show, etc.)
# but that can be left as an exercise for the reader :3
# Also the Polynomials.jl package have implemented most of those.

# Here, the whole point of this example; This function basically makes
# the variable, p, act as a polynomial function on x.
function (p::Poly{T})(x::T) where T <: Number
    ret = zero(T)
    for i in 1 : length(p.coeffs)
        ret += p.coeffs[i] * x^(i - 1)
    end
    ret
end

# Now any variable of type Poly can be used as if it was a function
# This gives some really clean syntax :)
p = Poly([0.0, -3.0, 0.0, 1.0]) # p = 0 - 3 x + 0 x^2 + 1 x^3
@show p(3.0)
