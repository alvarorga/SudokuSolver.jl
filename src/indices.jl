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

"""
    ix_block(i::Int, j::Int)

Indices of sites inside the same block of (i, j).
"""
function ix_block(i::Int, j::Int)
    bi = div(i-1, 3)*3
    bj = div(j-1, 3)*3
    ix = zeros(Int, 9)
    for ip=1:3
        for jp=1:3
            ix[3*(jp-1) + ip] = g2ix(bi+ip, bj+jp)
        end
    end
    return ix
end
