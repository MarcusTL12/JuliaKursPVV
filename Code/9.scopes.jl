# The global scope in julia behaves weirdly. This section shows how to
# cicumvent the issues that arise, but the bottom line here should be
# to avoid the global scope as much as humanly possible.
# Changing globals require ugly explicit syntax, globals cannot be
# strongly typed, and, in general, globals are significantly slower
# up to several orders of magnitude in some cases.

a = 5

# This works
if a > 2
    println(a)
    a += 3
end


for i in 1 : 3
    println(a)      # This works
    # a -= 1        # This does not work
end

# Declaring a to be global fixes this problem
for i in 1 : 3
    global a
    println(a)
    a -= 1
end

# None of this is a problem in functions, so do everything in functions
function main()
    a = 7
    for i in 1 : 3
        a -= 1
    end
    println(a)
end

main()

# An inline function body can be created with a "let" block.
# This creates a nameless function that is run immediately.
let a = 10
    for i in 1 : 3
        a -= 1
    end
    println(a)
end


# A "begin" block is similar to a let block, but it does not enforce
# a new scope, so this code is still in the global scope
begin
    a = 12
    for i in 1 : 3
        global a -= 1
    end
    println(a)
end

