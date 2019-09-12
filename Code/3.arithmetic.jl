

# Also possible to enforce types on local variables

function main()
    # Int is an alias for Int32 or Int64 depending on your installation
    # 32 bit vs 64 bit
    a::Int = 14
    b::Int = 7
    
    # Enforces the type of c for the rest of the scope
    c::Int = a + b
    @show typeof(c) c # The @show macro is basically a debug print
    
    # Normal division of integers returns Float64
    # Assignment to c tries to convert result to the
    # type of c as the type is enforced.
    # If unable to convert to Int it throws an appropriate exception
    c = a / b
    @show typeof(c) c
    
    # // is rational division. This returns a rational number
    c = a // b
    @show typeof(c) c
    
    
    # Integer division is done by div, fld or cld (floor divide/ceil divide)
    # div rounds towards zero (1.5 -> 1, -2.7 -> -2)
    # floor rounds downwards (1.5 -> 1, -2.7 -> -3)
    # ceil rounds upwards (1.5 -> 2, -2.7 -> -2)
    c = div(a, b)
    c = fld(a, b)
    c = cld(a, b)
    
    # Exponentiation is done with the ^ symbol as in most calculator programs
    c = a^b
    @show c
end

main()

