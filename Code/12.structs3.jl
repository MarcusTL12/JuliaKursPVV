
# This is a more complete example of a linked list implementation, but exists
# mainly to illustrate how to implement indexing and iteration.

# okay, this is the dirtiest hack I have ever done in julia.
# Julia is really finicky when it comes to redefining structs.
# Usually it isn't a problem if you haven't changed anything,
# but because of the recursive inclusion in the Node_ struct it was really
# unhappy, so this basically runs this if block the first time
# and not any subsequent times.
if !isdefined(@__MODULE__, :__first__)
__first__ = true

# The node struct that actually holds the values
mutable struct Node_{T}
    data::T
    prev::Union{Node_{T}, Nothing}
    next::Union{Node_{T}, Nothing}
end

# An alias for a type union such that we can set a node to the value nothing
# when we want to indicate the end of the list.
const Node{T} = Union{Node_{T}, Nothing}

# Since we made the alias for Node, we make this wrapper for the constructor
# of the actual Node_ object. There are probably better ways to do this
# but this works fine.
function make_node(data::T, prev::Node{T}, next::Node{T}) where T
    Node_{T}(data, prev, next)
end

# The wrapper struct for the nodes. Most of the methods will be implemented
# on this type.
# It is also specified as a subtype of the abstract type AbstractArray.
# This signalises that it will mostly act like an array
# and makes it possible to pass a LinkedList into a function that is specified
# to take in objects of type AbstractArray. This gives a bunch of functions
# that needs to be implemented, and some that can be overridden. All of these
# are listed under the "Interfaces" section in the julia docs.
# Here we will implement the required methods and the methods for iteration.
mutable struct LinkedList{T} <: AbstractArray{T, 1}
    head::Node{T}
    tail::Node{T}
    items::Int # Keeping track of how many items for quick length checking
    
    # Implementing a default constructor
    LinkedList{T}() where T = new{T}(nothing, nothing, 0)
end

end # End of the dirty hack

# Constructor to create a list from a collection of elements
function LinkedList(elems::AbstractArray{T}) where T
    l = LinkedList{T}()
    for e in elems
        push!(l, e)
    end
    l
end


# Not required for AbstractArray, but makes sense to implement
function Base.push!(l::LinkedList{T}, v::T) where T
    n_node = make_node(v, nothing, nothing)
    
    if l.head === nothing
        l.tail = l.head = n_node
    else
        l.tail.next = n_node
        n_node.prev = l.tail
        l.tail = n_node
        # n_node.next = l.head # Uncomment this one if you feel brave ;)
    end
    l.items += 1
    l
end

# One of the required functions for AbstractArray. size returns a tuple
# of all the dimensions, but this is a 1d collection so it only contains
# one element.
Base.size(l::LinkedList) = (l.items, )

# Implements the iteration function. This makes it possible to for example
# write something like "for element in list" to iterate through the list.
# The function returns a 2-tuple where the first element is the next iteration
# item and the second element is the next state. The state is some variable
# that determines the next element and state. When the function returns
# nothing, the loop is done.
function Base.iterate(l::LinkedList, state=l.head)
    if state === nothing
        nothing # If the state is nothing, we return nothing
    else
        (state.data, state.next) # Else the next item/state is returned
    end
end

# Implements a simple show function for nicer printing. The default show
# function is ridiculous when you have circular/recursive containment in
# your structs, so it is necessary to implement a nicer version.
function Base.show(io::IO, l::LinkedList{T}) where T
    show(io, l.items)
    write(io, "-element LinkedList{")
    show(io, T)
    write(io, "}:\n    ")
    first = true
    for elem in l
        if !first
            write(io, " → ")
        end
        first = false
        show(io, elem)
    end
end

# A utility function for both the getindex and setindex! functions
function findnode(l::LinkedList, i::Int)
    if !(1 <= i <= length(l))
        throw(BoundsError(l, i)) # Throwing an error if out of bounds
    end
    curnode = l.head
    for j in 1 : i - 1
        curnode = curnode.next
    end
    curnode
end

# Another required function for AbstractArray.
# This function makes it possible to read the element at a certain index
# with the syntax l[i]
Base.getindex(l::LinkedList, i::Int) = findnode(l, i).data

# The complimentary function for setting elements at a given index
# with corresponding syntax l[i] = v
Base.setindex!(l::LinkedList{T}, v::T, i::Int) where T = findnode(l, i).data = v


# Practial to override the copy function. In this case it it really
# simple to set up because of the way we made the constructor.
Base.copy(l::LinkedList) = LinkedList(l)

# Implementing the append function as well. Not necessary but practical to have.
function Base.append!(l::LinkedList{T}, l2::AbstractArray{T}) where T
    for elem in l2
        push!(l, elem)
    end
end

# Implementing insert! for a linked list is quite useful
function Base.insert!(l::LinkedList{T}, i::Int, v::T) where T
    node = findnode(l, i)
    n_node = make_node(v, node, node.next)
    if node.next !== nothing
        node.next.prev = n_node
    end
    node.next = n_node
    l
end

# Same goes for deleteat!
function Base.deleteat!(l::LinkedList, i::Int)
    node = findnode(l, i)
    if node.prev !== nothing
        node.prev.next = node.next
    end
    if node.next !== nothing
        node.next.prev = node.prev
    end
    l
end

# It can be useful to reverse a list
function Base.reverse!(l::LinkedList)
    cur_node = l.head
    for i = 1 : length(l)
        cur_node.prev, cur_node.next = cur_node.next, cur_node.prev
        cur_node = cur_node.prev
    end
    l.head, l.tail = l.tail, l.head
    l
end

# It can also be useful to make a reversed copy of a list
Base.reverse(l::LinkedList) = reverse!(copy(l))


# Some test code:

# Creating a linked list
l = LinkedList(1 : 5)
@show l

# showing the third element
@show l[3]

# setting the third element
l[3] = 7
@show l

# inserting the value 8 between 2nd and 3rd node
insert!(l, 2, 8)
@show l

# deleting the second node
deleteat!(l, 2)
@show l

# since all required functions for AbstractArray have been implemented
# standard functions, such as sort!, should now work. However if performance
# is important you should probably implement your own version of functions
# so that it is done more efficiently for the collection in question.
# for example the sort function here will do a lot of index operations
# and since finding a node in a linked list is O(n) complexity and
# sort! is O(n log n) list operations, the whole runtime becomes O(n^2 log n).
sort!(l)
@show l

