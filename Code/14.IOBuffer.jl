
# IOBuffers are like writing to a file in memory. They are really efficient
# when creating strings and work like any other IO object we've worked with.
io = IOBuffer()

a = 42
write(io, "i = ")
print(io, a)

# To retrieve the written data from the buffer we call take!(). This returns
# a Vector{UInt8} so to interpret it as a string we call String()
s = String(take!(io))

println(s)

