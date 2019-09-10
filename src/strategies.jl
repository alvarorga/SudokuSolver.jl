# Names of function strategies are based on:
# https://www.learn-sudoku.com/basic-techniques.html

"""
    update_cands!(s::Sudoku, i::Int, j::Int)

Update candidates if position (i, j) was fixed.
"""
function update_cands!(s::Sudoku, i::Int, j::Int)
    n = s.grid(i, j)
    # Check same row.
    for k=1:9
        if (s.cands[g2ix(i, k)]>>(n-1))&1 == 1
           s.cands[g2ix(i, k)] -= 1<<(n-1)
       end
    end
    # Check same column.
    for k=1:9
        if (s.cands[g2ix(k, j)]>>(n-1))&1 == 1
           s.cands[g2ix(k, j)] -= 1<<(n-1)
       end
    end
    # Check same block.
    return s
end

"""
    lone_singles!(s::Sudoku)

Make fixed sites with only one candidate.
https://www.learn-sudoku.com/lone-singles.html
"""
function lone_singles!(s::Sudoku)
    for ix=1:81
        if length(s.cands[ix]) == 1
            s.grid[ix] = trailing_zeros(s.cands[ix])+1
            s.cands[ix] == 0
        end
    end
    return s
end
