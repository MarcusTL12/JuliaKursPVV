
# Lists/Arrays/Vectors work very similarly to python

# A list can be constructed from a set of elements with [] brackets
l = [1, 2, 3, 4]

@show typeof(l)

# Indexing the array can be done with [] also.
# Keep in mind, arrays in julia are 1-indexed by default
@show l[2]

# The type of elements in the array can be enforced by writing
# the type directly in front of the brackets
l = Int32[1, 2, 3, 4]

@show typeof(l)

# An array will try to implicitly convert data to have a single
# element data type
l = [1, 2.3, 3//2]

@show l
@show typeof(l)

# However if this is not possible, the list will get the type Any.
# Arrays with multiple types are much more inefficient because of
# type bookkeeping.
l = [1, 2.3, 3//2, "hello"]

@show l
@show typeof(l)

# Julia natively supports multidimensional arrays, such as matrices, tensors
# etc. with a lot of linear algebra built into the language.
m = [
    1 2 3;
    4 5 6;
    7 8 9
]

display(m)  # display() is a pretty-print function that is nice for showing
            # matrices and other containers
@show typeof(m)

# Creating an "empty" array can be done in a couple different ways

# Creating an array with no elements is usually done with empty brackets []
l = []
# or with a specific type
l = Float32[]

# Creating an uninitialized array with a set amount of elements
# can be achieved by calling the Array constructor

l = Array{Int, 1}(undef, 100) # Creating a 1d array of 100 undefined elements

# when working with 1d arrays it is usually better to use the alias Vector
# for 1d array. Vector{T} is an alias for Array{T, 1}

l = Vector{Int}(undef, 100) # Does exactly the same as the line above

# however it is usually cleaner and safer to use the function zeros() or
# ones() to initialize the memory.
l = zeros(Int, 100) # creates an array of 100 zeros of type Int
l = ones(Int, 100) # same for ones

# Values can be added to the back of an array with the push! function.
l = [1, 2, 3, 4]
push!(l, 5)

@show l

# Reserving space in the buffer can be done with sizehint!
# That way pushing values to the array doesn't cause so many reallocations

sizehint!(l, 100) # reserving space for 100 elements

# Pushing to the front can be done with pushfirst!
pushfirst!(l, 0)

@show l

# Do not confuse push! with append!. Where append in python works as push!
# here, append! in julia concatenates a whole array to the back.
append!(l, [6, 7, 8, 9])

@show l

# Deleting an element at a specific index is done by deleteat!
# Keep in mind that deleting elements from an array is often slow
# as data has to be moved. In julia it is fast to delete elements near
# either end of the array as the shortest end is the one moved to fill
# the space.
deleteat!(l, 3)

@show l

# As in python, list can be created with a list comprehension
l = [i^2 for i in 1 : 5] # creates square numbers from 1 to 25
@show l

# As Julia supports multidimensional arrays, it also supports
# multidimensional list comprehensions
l = [x * y for y in 1 : 3, x in 1 : 4]
display(l)

# It is possible to view an array through a wrapper, making it differently
# organized without copying data, f.ex. the transpose of a matrix or
# viewing a multidimensional array as the raw memory as a 1d array.
# There are many different types of views in multiple different packages.
# search the documentation to see more

l2 = view(l, 3:-1:1, 1 : 4) # Flipping the matrix upside down
display(l2)

l2 = transpose(l) # transpose is a wrapper for a PermutedDimsArray
l2 = PermutedDimsArray(l, (2, 1)) # flips x and y dimensions
display(l2)


# Random numbers can be created in many different ways. Here are a few
# easy ones.

a = rand(Int64) # Create a random Int64
a = rand(Float64) # Create random Float64 in the range 0 : 1
a = rand(1 : 10) # Create a random Int in the given range
l = rand(1 : 10, 3, 4) # Create a random 3x4 matrix with entries in 1 : 10
display(l)

using Random
rand!(l, -100 : 100) # Fill l with random entries from -100 : 100
display(l)
