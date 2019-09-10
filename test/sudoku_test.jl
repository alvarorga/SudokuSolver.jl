using Test, SudokuSolver

@testset "Sudoku structure" begin
    s1 = sampleSudoku(1)

    @testset "Test candidates" begin
        @test s1.cands[1] == 1<<3 + 1<<4
        @test s1.cands[2] == 0
        @test s1.cands[36] == 1<<3
        @test s1.cands[38] == 1<<3 + 1<<6
        @test s1.cands[81] == 1<<1 + 1<<3 + 1<<5 + 1<<6
    end
end
