# Names of function strategies are based on:
# https://www.learn-sudoku.com/basic-techniques.html

"""
    lone_singles!(s::Sudoku)

Make fixed sites with only one candidate.
https://www.learn-sudoku.com/lone-singles.html
"""
function lone_singles!(s::Sudoku)
    for ix=1:81
        if length(s.candidates[ix]) == 1
            s.grid[ix] = trailing_zeros(s.candidates[ix])+1
            s.candidates[ix] == 0
        end
    end
    return s
end
