
# User defined types are made with the struct keyword. Member variables are
# listed in the struct body as follows.
# Keep in mind that julia does not support redefining of types by default,
# so whenever you change anything in the struct (field names/types, etc.)
# you have to restart the REPL.
# Alternatively you could look into the package Revise.jl which solves
# some of these problems.
struct TestType
    x
    y
    z
end

# Every struct gets a default constructor that is the typename taking
# in all the member variables in order.
t = TestType(1, 2, 3)

# Every struct also gets a default print function that shows the variable
# in style of the constructor.
@show t

# Accessing the member variables of the struct is done simply by just
# writing variable_name.field_name
# every field is always public as julia does not implement any heavy
# object oriented design.
@show t.x

# This line is illegal since struct are immutable by default.
# t.y = 5

# Field mutability can be achieved by adding the keyword "mutable" in front.
# However for simple structs, like this xyz-point like structure, it is
# much more efficient if you can avoid making it mutable. This has to do
# with how mutable struct are allocated differently then immutable ones.
# Read more in the "Types" section of the julia documentation.
mutable struct TestType2
    x::Float64
    y::Float64
    z::Float64
end

# Also as illustrated above, the fields in a struct can be strictly typed.
# This is usually a good idea since it makes the struct take a constant
# amount of space, and removes a lot of type bookkeping.

t2 = TestType2(1.68, 3.14, 2.71)

# With this mutable struct, the variable now behaves more like a general
# container (Array/vector) so you can change the fields.
t2.y = 1.23
@show t2

# You can also make parametric types, kind of like templates in C++.
# This essentially creates a new type for each new T, so it alleviates the
# problem of keeping track of the types of the individual fields.
struct TestType3{T}
    x::T
    y::T
    z::T
end

# This now constructs a TestType3{Int64}
t3 = TestType3(1, 2, 3)
@show t3


# This will be the example struct throughout the rest of the file.
struct Polar{T<:Real}
    r::T
    θ::T
    
    # You might want to make your own constructors for a type.
    # These are typically made inside the struct body since this overrides
    # the creation of the default constructor described above.
    function Polar(r::T, θ::T) where T <: Real
        # Doing some constructy stuff
        println("Creating Polar number (r = $r, θ = $θ)")
        
        # The actual variable is created by calling the "new()" function
        # which acts as the default constructor. This however is just
        # accessible to functions defined inside the struct body.
        new{T}(r, θ)
    end
    
    # You might want to implement multiple different constructors.
    # This one is short and simple so it can be created with the inline syntax.
    # The zero(T) function finds the apropriate "zero" value
    # for the given type T. That way no implicit conversions have to be done.
    Polar{T}() where T <: Real = new{T}(zero(T), zero(T))
end

# Not all constructors have to be defined inside the struct body, but here
# outside the body we no longer have access to the "new()" function since
# the compiler doesn't have any way to infer which type "new" would refer
# to out here. So instead we have to use one of the constructors we defined
# inside the struct.
# This constructor is very similar to the Polar{T}() function but instead
# of writing p = Polar{Int}() to take the type in as a template argument
# you would pass the type in as an actual argument; p = Polar(Int)
Polar(::Type{T}) where T <: Real = Polar{T}()


# Constructing with the first constructor
p = Polar(3.14, 2.71)
@show p

# Constructing with the empty constructor
p = Polar{Int}()
@show p

# Constructing with the constructor taking the type as an argument
p = Polar(Float16)
@show p


# You might want to overload som basic operators and functions on your
# type. One common thing to want to override is how your variables are printed.
# Since there are so many different ways of converting a variable to text
# (print, println, @printf, string, @show, display, etc.)
# it can be difficult to find out which function is actually responsible
# for converting to text.
# This function turns out to be the Base.show() function.
# It takes in an IO stream object and and the variable you want to show.

# Since the funtion is from the Base module
# we have to override Base.show specifically
# Also it is very important to actually specify the type of the variable here
# so that we are actually specifying the show function for our type only
# and not for any general type.
function Base.show(io::IO, p::Polar)
    # Say we want to print our polar number as r * e^(i θ) style string
    show(io, p.r) # non strings we want to recursively show
    write(io, " ⋅ ℯ^(i ⋅ ") # strings we want to write directly with write
    show(io, p.θ)
    write(io, ")")
end

# Now our polar numbers are printed as we specified
p = Polar(3.14, 2.71)
@show p
println(p)
display(p)

# Even converting to a string is now done with our show functon
s = string(p)
@show s


# Overloading operators is even simpler as every infix operator is just a
# function; a + b is equivalent to +(a, b) (for all you lisp lovers)

# For some reason we cannot write the Base.* inline for infix operators
import Base.*
*(p1::Polar{T}, p2::Polar{T}) where T = Polar(p1.r * p2.r, p1.θ + p2.θ)

# Multiplication between different types might also be useful
*(x::T, p::Polar{T}) where T = Polar(x * p.r, p.θ)
# Implementing the reverse mulitplication such that it becomes commutative
*(p::Polar{T}, x::T) where T = x * p

p1 = Polar(2.0, 15.0)
p2 = Polar(3.0, 30.0)
p3 = p1 * p2
@show p3

# The in-place arithmetic operators (+=, -=, *=, /=, etc.) are not actual
# operators but rather just an alias for a = a * b so they need not be
# implemented seperately. If the memory copying is a problem and you
# really have to do it in-place the way to do that would be to make some
# sort of mult!(p, x) function.
p3 *= 0.5
@show p3
