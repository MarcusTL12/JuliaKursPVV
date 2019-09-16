
# Dicts (dictionaries/maps) are not as simple as in python, resembling
# more the way modern c++ does it

# Dicts are usually created from an array of "Pair" types (First => Last)
# The type of the dict keys and values are automatically inferred.
d = Dict([
    "foo" => 3,
    "bar" => 7
])
display(d)

# A dict can also be initialized as an array of two tuples. This works
# identically to the example above
d = Dict([
    ("foo", 2.71),
    ("bar", 3.14)
])
display(d)

# Values can be pushed to the dict similarly to an array.
# Keep in mind that creating an empty dict like this gives the type
# Dict{Any, Any} which might be somewhat slower because of having
# to work for general types
d = Dict()
push!(d, "foo" => 1//2)
push!(d, "bar" => 22//7)
display(d)

# The problem above can be mitigated by inferring the types manually
d = Dict{String, Rational{Int}}()
push!(d, "foo" => 1//2)
push!(d, "bar" => 22//7)
display(d)

# A key can be deleted from a dict with delete!()
delete!(d, "foo")
display(d)

# To check if a certain key exists in the dict, the haskey function is used
println(haskey(d, "foo")) # false
println(haskey(d, "bar")) # true

# Indexing a dict is done with brackets like for any array
println(d["bar"])
