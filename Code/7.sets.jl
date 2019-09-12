
# Sets are created from lists of elements and duplicates are removed
s = Set(['a', 'b', 'c', 'b'])
display(s)
@show 'b' in s

# As with other collections, elements can be added with push!
push!(s, 'd')
display(s)

# And elements are removed with delete!
delete!(s, 'b')
display(s)

# An empty set can be made just like an empty dict, but again this forces
# it to accept elements of type Any, which can be an minor slowdown
s = Set()

# This is of course fixed by infering the type when creating the dict
s = Set{Int}()
push!(s, 2)
display(s)

# Usual set operations like union, intersect, difference and checking if
# one is a subset of another, are all implemented, many with
# unicode infix operators
s1 = Set([1, 2, 4, 8, 16])
s2 = Set([2, 3, 5, 16])

@show union(s1, s2) # Takes the set union
@show s1 ∪ s2 # Equvialent to the line above (\cup for the unicode macro)

@show intersect(s1, s2) # Set intesect
@show s1 ∩ s2 # Unicode version (\cap)

@show setdiff(s1, s2) # Set difference. No unicode replacement for this one
@show symdiff(s1, s2) # symetric difference. No unicode here either

union!(s1, s2) # Equvialent to s1 = s1 ∪ s2
@show s1

intersect!(s1, s2) # Equvialent to s1 = s1 ∩ s2
@show s1

# Check if s1 is a subset of s2. (\subseteq)
@show s1 ⊆ s2

