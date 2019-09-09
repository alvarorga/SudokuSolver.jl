export Sudoku

"""
    struct Sudoku

Sudoku structure, contains all info about fixed numbers and candidates.

Fields:
    grid::Matrix{UInt}: 9x9 matrix with numbers that are already known to be in
        the solution. An unknow value is represented by 0.
    candidates::Vector{Vector{UInt}}: a 81 length vector with all candidate
        numbers that can be in each slot of the grid. Grid index (i, j)
        corresponds to position 9*(i-1) + j in candidates.
"""
struct Sudoku
    grid::Matrix{UInt}
    candidates::Vector{Vector{UInt}}
end
