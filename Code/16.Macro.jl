
# Julia comes with a lot of useful macros. You've already seen the @show macro.
x = 5
@show x

# Macros are a small part of julias huge metaprogramming system.
# There exists a bunch of useful macros, both in julia itself, and in
# different packages. A macro is basically a function that takes in a list
# of arguments and generates a code block at compiletime. It is possible
# to create your own macros, but that takes some reading up on the
# metaprogramming section in the julia docs.


# Probably one of my most used macros is the @time macro
reallyslowfunction() = sleep(2)
@time reallyslowfunction()

# If you want to time a whole code block this is done with a "begin" block
@time begin
    # Slow code
    sleep(1)
end

# The @inbounds macro removes all checks to see if you try to access elements
# outside any container, so might be faster, but definitely more unsafe.
a = [1, 2, 3]
@inbounds println(a[2])

