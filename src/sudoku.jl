export Sudoku,
       sampleSudoku

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

"""
    Sudoku(grid::Matrix{Int})::Sudoku

Make a Sudoku structure based on an initil grid.
"""
function Sudoku(grid::Matrix{Int})::Sudoku
    return Sudoku(grid, write_candidates(grid))
end

"""
    sampleSudoku(i::Int)::Sudoku

Create a Sudoku taken from a sample of 6 possible ones.
"""
function sampleSudoku(i::Int)::Sudoku
    i > 6 && throw("Number i: $i not valid.")

    local grid
    if i == 1
        grid = [
            0 0 3 0 2 0 6 0 0;
            9 0 0 3 0 5 0 0 1;
            0 0 1 8 0 6 4 0 0;
            0 0 8 1 0 2 9 0 0;
            7 0 0 0 0 0 0 0 8;
            0 0 6 7 0 8 2 0 0;
            0 0 2 6 0 9 5 0 0;
            8 0 0 2 0 3 0 0 9;
            0 0 5 0 1 0 3 0 0;
        ]
    elseif i == 2
        grid = [
            2 0 0 0 8 0 3 0 0;
            0 6 0 0 7 0 0 8 4;
            0 3 0 5 0 0 2 0 9;
            0 0 0 1 0 5 4 0 8;
            0 0 0 0 0 0 0 0 0;
            4 0 2 7 0 6 0 0 0;
            3 0 1 0 0 7 0 4 0;
            7 2 0 0 4 0 0 6 0;
            0 0 4 0 1 0 0 0 3;
        ]
    elseif i == 3
        grid = [
            0 2 0 0 3 0 0 9 0;
            0 0 0 9 0 7 0 0 0;
            9 0 0 2 0 8 0 0 5;
            0 0 4 8 0 6 5 0 0;
            6 0 7 0 0 0 2 0 8;
            0 0 3 1 0 2 9 0 0;
            8 0 0 6 0 5 0 0 7;
            0 0 0 3 0 9 0 0 0;
            0 3 0 0 2 0 0 5 0;
        ]
    elseif i == 4
        grid = [
            0 0 1 0 0 7 0 9 0;
            5 9 0 0 8 0 0 0 1;
            0 3 0 0 0 0 0 8 0;
            0 0 0 0 0 5 8 0 0;
            0 5 0 0 6 0 0 2 0;
            0 0 4 1 0 0 0 0 0;
            0 8 0 0 0 0 0 3 0;
            1 0 0 0 2 0 0 7 9;
            0 2 0 7 0 0 4 0 0;
        ]
    elseif i == 5
        grid = [
            0 0 0 0 0 3 0 1 7;
            0 1 5 0 0 9 0 0 8;
            0 6 0 0 0 0 0 0 0;
            1 0 0 0 0 7 0 0 0;
            0 0 9 0 0 0 2 0 0;
            0 0 0 5 0 0 0 0 4;
            0 0 0 0 0 0 0 2 0;
            5 0 0 6 0 0 3 4 0;
            3 4 0 2 0 0 0 0 0;
        ]
    elseif i == 6
        grid = [
            3 0 0 2 0 0 0 0 0;
            0 0 0 1 0 7 0 0 0;
            7 0 6 0 3 0 5 0 0;
            0 7 0 0 0 9 0 8 0;
            9 0 0 0 2 0 0 0 4;
            0 1 0 8 0 0 0 5 0;
            0 0 9 0 4 0 3 0 1;
            0 0 0 7 0 2 0 0 0;
            0 0 0 0 0 8 0 0 6;
        ]
    end
    return Sudoku(grid)
end

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
    write_candidates(grid::Matrix{Int})::Vector{Int}

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
