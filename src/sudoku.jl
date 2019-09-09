export Sudoku

"""
    struct Sudoku

Sudoku structure, contains all info about fixed numbers and candidates.

Fields:
    grid::Matrix{Int}: 9x9 matrix with numbers that are already known to be in
        the solution. An unknow value is represented by 0.
    candidates::Vector{Vector{Int}}: a 81 length vector with all candidate
        numbers that can be in each slot of the grid. Grid index (i, j)
        corresponds to position 9*(i-1) + j in candidates.
"""
struct Sudoku
    grid::Matrix{Int}
    candidates::Vector{Vector{Int}}
end

function Sudoku(grid::Matrix{Int})
    return Sudoku(grid, write_candidates(grid))
end

"""
    write_candidates(grid::Matrix{Int})::Vector{Vector{Int}}

Write the candidate numbers at each position in the grid for a given grid.
"""
function write_candidates(grid::Matrix{Int})::Vector{Vector{Int}}
    candidates = fill(Vector{Int}(), 81)
    for i=1:9
        for j=1:9
            ix = 9*(i-1) + j
            cands = Vector{Int}()
            for c=1:9
                # Discard numbers in the same row or column.
                any(grid[i, :] .== c) && continue
                any(grid[:, j] .== c) && continue
                # Discard numbers in the same 3x3 block.
                bi = div(i-1, 3)*3
                bj = div(j-1, 3)*3
                any(grid[bi+1:bi+3, bj+1:bj+3] .== c) && continue

                push!(cands, c)
            end
            candidates[ix] = cands
        end
    end
    return candidates
end
