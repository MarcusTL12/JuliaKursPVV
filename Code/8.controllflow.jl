
a = 3
b = 5

# if statements are made very similarly to other languages like python
if a < b
    println("<")
elseif a > b
    println(">")
else
    println("=")
end


i = 10

# While loops are made similarly to if statements
while i >= 0
    print(i, ' ')
    global i -= 1
end

println()

l = []

# A typical range based for loop is made similarly to python
# with matlab style range syntax
for i in 1 : 10
    push!(l, i^2)
end
println(l)

# A for-each style for loop is also similar to python
for i in l
    print(i, ' ')
end
println()

# Reverse ranges can be achieved by specifying the steplength as the
# middle argument in the range
for i in length(l) : -1 : 1
    print(l[i], ' ')
end
println()

# A reverse for-each loop can be achieved a couple different ways.
# Perhaps the cleanest way is to just create the reverse array and
# iterating over that. This however copies the whole array to a new
# reversed one, so it is a bit memory inefficient.
for i in reverse(l)
    print(i, ' ')
end
println()

# This problem can be mitigated by using an array view that views the
# array in reverse. This is fine, but it doesn't look as clean anymore.
for i in view(l, length(l) : -1 : 1)
    print(i, ' ')
end
println()
