export Sudoku,
       sampleSudoku

"""
    struct Sudoku

Sudoku structure, contains all info about fixed numbers and candidates.

Fields:
    grid::Matrix{Int}: 9x9 matrix with numbers that are already known to be in
        the solution. An unknow value is represented by 0.
    cands::Vector{Int}: every entry of this length-81 vector is an
        integer value where the binary bits set to 1 represent the possible
        numbers that can go in that position. Example: 001101001 means that
        numbers {1, 4, 6, 7} are all candidates to be in that cell.
"""
struct Sudoku
    grid::Matrix{Int}
    cands::Vector{Int}
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
    write_candidates(grid::Matrix{Int})::Vector{Int}

Write the candidate numbers at each position in the grid for a given grid.
"""
function write_candidates(grid::Matrix{Int})::Vector{Int}
    cands = zeros(Int, 81)
    for i=1:9
        for j=1:9
            # Skip if number is already fixed.
            grid[i, j] != 0 && continue

            ix = g2ix(i, j)
            for c=1:9
                # Discard numbers in the same row or column.
                any(grid[i, :] .== c) && continue
                any(grid[:, j] .== c) && continue
                # Discard numbers in the same 3x3 block.
                bi = div(i-1, 3)*3
                bj = div(j-1, 3)*3
                any(grid[bi+1:bi+3, bj+1:bj+3] .== c) && continue

                cands[ix] += 1<<(c-1)
            end
        end
    end
    return cands
end
