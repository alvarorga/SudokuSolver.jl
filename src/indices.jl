"""
    g2ix(i::Int, j::Int)::Int

Grid to index. Take a grid position (i, j) and return its flattened index.
"""
@inline g2ix(i::Int, j::Int) = 9*(j-1) + i

"""
    ix2g(ix::Int)::Tuple{Int, Int}

Index to grid. Take an index and return its corresponding grid position (i, j).
"""
@inline ix2g(ix::Int) = ((ix-1)%9+1, div(ix-1, 9)+1)
